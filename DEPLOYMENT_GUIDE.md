# VELTRIX SPORTS - DEPLOYMENT GUIDE
## Complete Deployment Documentation

---

# DEPLOYMENT OVERVIEW

```
Environment: Production, Staging, Development
Cloud Provider: AWS
CDN: CloudFront
Database: PostgreSQL (RDS)
Cache: Redis (ElastiCache)
Storage: S3
```

---

# 1. AWS SETUP

## 1.1 Create AWS Account

1. Go to https://aws.amazon.com
2. Click "Create an AWS Account"
3. Enter email, password, and account name
4. Enter contact information
5. Enter payment method
6. Verify identity
7. Select support plan

---

## 1.2 Create IAM User

```bash
# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure AWS CLI
aws configure
# Enter Access Key ID
# Enter Secret Access Key
# Enter region (ap-south-1 for Mumbai)
# Enter output format (json)
```

---

## 1.3 Create VPC

```bash
# Create VPC
aws ec2 create-vpc \
  --cidr-block 10.0.0.0/16 \
  --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=veltrix-vpc}]'

# Create Public Subnet
aws ec2 create-subnet \
  --vpc-id vpc-xxxxx \
  --cidr-block 10.0.1.0/24 \
  --availability-zone ap-south-1a \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=veltrix-public-1a}]'

# Create Private Subnet
aws ec2 create-subnet \
  --vpc-id vpc-xxxxx \
  --cidr-block 10.0.2.0/24 \
  --availability-zone ap-south-1a \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=veltrix-private-1a}]'

# Create Internet Gateway
aws ec2 create-internet-gateway \
  --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=veltrix-igw}]'

# Attach Internet Gateway to VPC
aws ec2 attach-internet-gateway \
  --internet-gateway-id igw-xxxxx \
  --vpc-id vpc-xxxxx

# Create Route Table
aws ec2 create-route-table \
  --vpc-id vpc-xxxxx \
  --tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=veltrix-public-rt}]'

# Create Route
aws ec2 create-route \
  --route-table-id rtb-xxxxx \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id igw-xxxxx

# Associate Route Table with Public Subnet
aws ec2 associate-route-table \
  --route-table-id rtb-xxxxx \
  --subnet-id subnet-xxxxx
```

---

# 2. RDS SETUP

## 2.1 Create DB Subnet Group

```bash
aws rds create-db-subnet-group \
  --db-subnet-group-name veltrix-db-subnet-group \
  --db-subnet-group-description "Veltrix DB Subnet Group" \
  --subnet-ids '["subnet-xxxxx","subnet-yyyyy"]'
```

## 2.2 Create RDS Instance

```bash
aws rds create-db-instance \
  --db-instance-identifier veltrix-db \
  --db-instance-class db.t3.micro \
  --engine postgres \
  --engine-version 14 \
  --master-username veltrix_admin \
  --master-user-password SecurePassword123! \
  --allocated-storage 20 \
  --max-allocated-storage 100 \
  --vpc-security-group-ids sg-xxxxx \
  --db-subnet-group-name veltrix-db-subnet-group \
  --backup-retention-period 7 \
  --multi-az \
  --storage-encrypted \
  --publicly-accessible false \
  --tags Key=Name,Value=veltrix-db
```

---

# 3. ELASTICACHE SETUP

## 3.1 Create Redis Cluster

```bash
aws elasticache create-cache-cluster \
  --cache-cluster-id veltrix-redis \
  --cache-node-type cache.t3.micro \
  --engine redis \
  --engine-version 6.x \
  --num-cache-nodes 1 \
  --vpc-security-group-ids sg-xxxxx \
  --cache-subnet-group-name veltrix-redis-subnet-group \
  --tags Key=Name,Value=veltrix-redis
```

---

# 4. S3 SETUP

## 4.1 Create S3 Bucket

```bash
# Create bucket
aws s3api create-bucket \
  --bucket veltrix-media \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1

# Enable versioning
aws s3api put-bucket-versioning \
  --bucket veltrix-media \
  --versioning-configuration Status=Enabled

# Enable encryption
aws s3api put-bucket-encryption \
  --bucket veltrix-media \
  --server-side-encryption-configuration '{
    "Rules": [
      {
        "ApplyServerSideEncryptionByDefault": {
          "SSEAlgorithm": "aws:kms"
        }
      }
    ]
  }'

# Block public access
aws s3api put-public-access-block \
  --bucket veltrix-media \
  --public-access-block-configuration \
    BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true
```

---

# 5. CLOUDFRONT SETUP

## 5.1 Create CloudFront Distribution

```bash
aws cloudfront create-distribution \
  --distribution-config '{
    "CallerReference": "veltrix-cdn",
    "Origins": {
      "Quantity": 1,
      "Items": [
        {
          "Id": "veltrix-media",
          "DomainName": "veltrix-media.s3.ap-south-1.amazonaws.com",
          "S3OriginConfig": {
            "OriginAccessIdentity": ""
          }
        }
      ]
    },
    "DefaultCacheBehavior": {
      "TargetOriginId": "veltrix-media",
      "ViewerProtocolPolicy": "redirect-to-https",
      "AllowedMethods": {
        "Quantity": 7,
        "Items": ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
      },
      "ForwardedValues": {
        "QueryString": false,
        "Cookies": {
          "Forward": "none"
        }
      },
      "MinTTL": 0,
      "DefaultTTL": 86400,
      "MaxTTL": 31536000
    },
    "Comment": "Veltrix Sports CDN",
    "Enabled": true,
    "DefaultRootObject": "index.html",
    "CustomErrorResponses": {
      "Quantity": 1,
      "Items": [
        {
          "ErrorCode": 404,
          "ResponsePagePath": "/index.html",
          "ResponseCode": "200",
          "ErrorCachingMinTTL": 300
        }
      ]
    }
  }'
```

---

# 6. COGNITO SETUP

## 6.1 Create User Pool

```bash
aws cognito-idp create-user-pool \
  --pool-name veltrix-users \
  --auto-verified-attributes email phone_number \
  --username-attributes email phone_number \
  --password-policy '{
    "MinimumLength": 8,
    "RequireUppercase": true,
    "RequireLowercase": true,
    "RequireNumbers": true,
    "RequireSymbols": false
  }' \
  --schema '[
    {
      "Name": "email",
      "Required": true,
      "Mutable": true
    },
    {
      "Name": "phone_number",
      "Required": true,
      "Mutable": true
    },
    {
      "Name": "name",
      "Required": true,
      "Mutable": true
    }
  ]'
```

## 6.2 Create App Client

```bash
aws cognito-idp create-user-pool-client \
  --user-pool-id us-east-1_xxxxx \
  --client-name veltrix-app \
  --generate-secret \
  --explicit-auth-flows ALLOW_USER_PASSWORD_AUTH ALLOW_REFRESH_TOKEN_AUTH \
  --prevent-user-existence-user-credentials \
  --supported-identity-providers COGNITO
```

---

# 7. EC2 SETUP

## 7.1 Create EC2 Instance

```bash
# Launch instance
aws ec2 run-instances \
  --image-id ami-xxxxx \
  --instance-type t3.small \
  --key-name veltrix-key \
  --security-group-ids sg-xxxxx \
  --subnet-id subnet-xxxxx \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=veltrix-api}]'

# Assign Elastic IP
aws ec2 allocate-address --domain vpc
aws ec2 associate-address --instance-id i-xxxxx --allocation-id eipalloc-xxxxx
```

## 7.2 Setup Node.js on EC2

```bash
# SSH into instance
ssh -i veltrix-key.pem ubuntu@ec2-xx-xx-xx-xx.ap-south-1.compute.amazonaws.com

# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Install PM2
sudo npm install -g pm2

# Setup firewall
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable
```

---

# 8. SSL CERTIFICATE

## 8.1 Request Certificate

```bash
aws acm request-certificate \
  --domain-name veltrixsports.com \
  --subject-alternative-names "*.veltrixsports.com" \
  --validation-method DNS
```

## 8.2 Verify Domain

1. Go to AWS Certificate Manager
2. Click on the certificate
3. Copy the CNAME record
4. Add to DNS provider (GoDaddy, Namecheap, etc.)
5. Wait for validation

---

# 9. DEPLOYMENT SCRIPTS

## 9.1 Backend Deployment

```bash
#!/bin/bash
# deploy-backend.sh

echo "Starting backend deployment..."

# Build
cd backend
npm install
npm run build

# Upload to S3
aws s3 sync dist/ s3://veltrix-backend/dist/

# Deploy to EC2
ssh -i veltrix-key.pem ubuntu@$EC2_IP << 'EOF'
  cd /var/www/veltrix
  git pull
  npm install
  npm run build
  pm2 restart veltrix-api
EOF

echo "Backend deployment complete!"
```

## 9.2 Frontend Deployment

```bash
#!/bin/bash
# deploy-frontend.sh

echo "Starting frontend deployment..."

# Build Flutter web
cd veltrix_sports
flutter build web --release

# Upload to S3
aws s3 sync build/web/ s3://veltrix-frontend/ --delete

# Invalidate CloudFront cache
aws cloudfront create-invalidation \
  --distribution-id EXXXXX \
  --paths "/*"

echo "Frontend deployment complete!"
```

---

# 10. ENVIRONMENT VARIABLES

## 10.1 Backend (.env)

```env
# Database
DATABASE_URL=postgresql://veltrix_admin:SecurePassword123!@veltrix-db.xxxx.ap-south-1.rds.amazonaws.com:5432/veltrix

# Redis
REDIS_URL=redis://veltrix-redis.xxxx.0001.ap-south-1.cache.amazonaws.com:6379

# AWS
AWS_REGION=ap-south-1
AWS_ACCESS_KEY_ID=xxxxx
AWS_SECRET_ACCESS_KEY=xxxxx
AWS_S3_BUCKET=veltrix-media

# Firebase
FIREBASE_PROJECT_ID=veltrix-sports
FIREBASE_PRIVATE_KEY=xxxxx
FIREBASE_CLIENT_EMAIL=xxxxx

# Razorpay
RAZORPAY_KEY_ID=rzp_test_xxxxx
RAZORPAY_KEY_SECRET=xxxxx

# JWT
JWT_SECRET=your-super-secret-jwt-key
JWT_EXPIRY=7d

# App
APP_URL=https://api.veltrixsports.com
FRONTEND_URL=https://veltrixsports.com
```

## 10.2 Frontend (.env)

```env
# API
API_BASE_URL=https://api.veltrixsports.com/v1

# Firebase
FIREBASE_API_KEY=xxxxx
FIREBASE_AUTH_DOMAIN=veltrix-sports.firebaseapp.com
FIREBASE_PROJECT_ID=veltrix-sports
FIREBASE_STORAGE_BUCKET=veltrix-sports.appspot.com
FIREBASE_MESSAGING_SENDER_ID=xxxxx
FIREBASE_APP_ID=xxxxx

# Razorpay
RAZORPAY_KEY_ID=rzp_test_xxxxx
```

---

# 11. DOCKER SETUP

## 11.1 Backend Dockerfile

```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY dist ./dist

EXPOSE 3000

CMD ["node", "dist/main.js"]
```

## 11.2 Docker Compose

```yaml
version: '3.8'

services:
  api:
    build: ./backend
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgresql://veltrix_admin:SecurePassword123!@db:5432/veltrix
      - REDIS_URL=redis://cache:6379
    depends_on:
      - db
      - cache

  db:
    image: postgres:14-alpine
    environment:
      - POSTGRES_USER=veltrix_admin
      - POSTGRES_PASSWORD=SecurePassword123!
      - POSTGRES_DB=veltrix
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  cache:
    image: redis:6-alpine
    ports:
      - "6379:6379"

volumes:
  postgres_data:
```

---

# 12. CI/CD PIPELINE

## 12.1 GitHub Actions

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.41.9'
      - run: flutter pub get
      - run: flutter test

  deploy-backend:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: cd backend && npm install && npm run build
      - name: Deploy to EC2
        uses: appleboy/ssh-action@master
        with:
          host: ${{ secrets.EC2_HOST }}
          username: ubuntu
          key: ${{ secrets.EC2_KEY }}
          script: |
            cd /var/www/veltrix
            git pull
            npm install
            npm run build
            pm2 restart veltrix-api

  deploy-frontend:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.41.9'
      - run: flutter pub get
      - run: flutter build web --release
      - name: Deploy to S3
        uses: jakejarvis/s3-sync-action@master
        with:
          args: --delete
        env:
          AWS_S3_BUCKET: veltrix-frontend
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          SOURCE_DIR: veltrix_sports/build/web/
```

---

# 13. MONITORING

## 13.1 CloudWatch Setup

```bash
# Create alarm for CPU
aws cloudwatch put-metric-alarm \
  --alarm-name veltrix-cpu-high \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --dimensions Name=InstanceId,Value=i-xxxxx \
  --alarm-actions arn:aws:sns:ap-south-1:xxxxx:veltrix-alerts

# Create alarm for database connections
aws cloudwatch put-metric-alarm \
  --alarm-name veltrix-db-connections-high \
  --metric-name DatabaseConnections \
  --namespace AWS/RDS \
  --statistic Average \
  --period 300 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --dimensions Name=DBInstanceIdentifier,Value=veltrix-db \
  --alarm-actions arn:aws:sns:ap-south-1:xxxxx:veltrix-alerts
```

---

# 14. BACKUP STRATEGY

## 14.1 Database Backup

```bash
# Automated daily backup
aws rds modify-db-instance \
  --db-instance-identifier veltrix-db \
  --backup-retention-period 7 \
  --preferred-backup-window 03:00-04:00

# Manual backup
aws rds create-db-instance-backup \
  --db-instance-identifier veltrix-db \
  --db-backup-name veltrix-backup-manual
```

## 14.2 S3 Backup

```bash
# Enable versioning
aws s3api put-bucket-versioning \
  --bucket veltrix-media \
  --versioning-configuration Status=Enabled

# Enable lifecycle rules
aws s3api put-bucket-lifecycle-configuration \
  --bucket veltrix-media \
  --lifecycle-configuration '{
    "Rules": [
      {
        "ID": "backup",
        "Status": "Enabled",
        "Transitions": [
          {
            "Days": 30,
            "StorageClass": "STANDARD_IA"
          },
          {
            "Days": 90,
            "StorageClass": "GLACIER"
          }
        ]
      }
    ]
  }'
```

---

# 15. DISASTER RECOVERY

## 15.1 RTO/RPO

| Metric | Target | Strategy |
|--------|--------|----------|
| RTO | 1 hour | Multi-AZ, Automated failover |
| RPO | 5 minutes | Continuous backup, WAL archiving |

## 15.2 Recovery Steps

1. **Database Recovery**
   ```bash
   aws rds restore-db-instance-from-db-snapshot \
     --db-instance-identifier veltrix-db-restored \
     --db-snapshot-identifier veltrix-backup-latest
   ```

2. **S3 Recovery**
   ```bash
   aws s3 sync s3://veltrix-backup/ s3://veltrix-media/
   ```

3. **EC2 Recovery**
   ```bash
   aws ec2 run-instances \
     --image-id ami-xxxxx \
     --instance-type t3.small \
     --user-data file://userdata.sh
   ```

---

# 16. CHECKLIST

## Pre-Deployment
- [ ] All tests pass
- [ ] Environment variables set
- [ ] Database migrations complete
- [ ] SSL certificate valid
- [ ] DNS configured
- [ ] Backup verified

## Deployment
- [ ] Backend deployed
- [ ] Frontend deployed
- [ ] Database connected
- [ ] Redis connected
- [ ] S3 accessible
- [ ] CloudFront working

## Post-Deployment
- [ ] Smoke tests pass
- [ ] Monitoring alerts configured
- [ ] Logs accessible
- [ ] Performance acceptable
- [ ] Security scan clean

---

**Document Version**: 1.0
**Last Updated**: August 29, 2026

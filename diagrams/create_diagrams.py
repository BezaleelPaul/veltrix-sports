"""
Veltrix Sports - Diagram Generator
Creates UML diagrams, flowcharts, and architecture diagrams
"""

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from matplotlib.patches import FancyBboxPatch, FancyArrowPatch
import numpy as np
import os

# Output directory
OUTPUT_DIR = os.path.dirname(os.path.abspath(__file__))

def save_diagram(fig, filename):
    """Save diagram to file"""
    filepath = os.path.join(OUTPUT_DIR, filename)
    fig.savefig(filepath, dpi=150, bbox_inches='tight', facecolor='white')
    plt.close(fig)
    print(f"Created: {filename}")

def draw_box(ax, x, y, width, height, text, color='#3498db', text_color='white', fontsize=10):
    """Draw a rounded box with text"""
    box = FancyBboxPatch((x - width/2, y - height/2), width, height,
                         boxstyle="round,pad=0.1", 
                         facecolor=color, edgecolor='#2c3e50', linewidth=2)
    ax.add_patch(box)
    ax.text(x, y, text, ha='center', va='center', fontsize=fontsize, 
            fontweight='bold', color=text_color, wrap=True)

def draw_arrow(ax, x1, y1, x2, y2, text='', color='#2c3e50'):
    """Draw arrow between points"""
    ax.annotate('', xy=(x2, y2), xytext=(x1, y1),
                arrowprops=dict(arrowstyle='->', color=color, lw=2))
    if text:
        mid_x, mid_y = (x1 + x2) / 2, (y1 + y2) / 2
        ax.text(mid_x, mid_y, text, ha='center', va='center', fontsize=8,
                bbox=dict(boxstyle='round,pad=0.2', facecolor='yellow', alpha=0.8))

# ============================================================
# 1. SYSTEM ARCHITECTURE DIAGRAM
# ============================================================
def create_system_architecture():
    fig, ax = plt.subplots(1, 1, figsize=(14, 10))
    ax.set_xlim(0, 14)
    ax.set_ylim(0, 10)
    ax.axis('off')
    ax.set_title('Veltrix Sports - System Architecture', fontsize=16, fontweight='bold', pad=20)
    
    # Client Layer
    draw_box(ax, 2, 9, 2.5, 0.8, 'Android App', '#e74c3c')
    draw_box(ax, 7, 9, 2.5, 0.8, 'iOS App', '#3498db')
    draw_box(ax, 12, 9, 2.5, 0.8, 'Web App', '#2ecc71')
    
    # API Gateway
    draw_box(ax, 7, 7.5, 4, 0.8, 'API Gateway (AWS API Gateway)', '#9b59b6')
    
    # Backend Services
    draw_box(ax, 2, 6, 2.5, 0.8, 'Auth Service\n(Cognito)', '#e67e22')
    draw_box(ax, 7, 6, 2.5, 0.8, 'Main API\n(Node.js/Express)', '#1abc9c')
    draw_box(ax, 12, 6, 2.5, 0.8, 'Payment Service\n(Razorpay)', '#e74c3c')
    
    # Data Layer
    draw_box(ax, 2, 4.5, 2.5, 0.8, 'PostgreSQL\n(RDS)', '#34495e')
    draw_box(ax, 7, 4.5, 2.5, 0.8, 'Redis Cache\n(ElastiCache)', '#c0392b')
    draw_box(ax, 12, 4.5, 2.5, 0.8, 'S3 Storage', '#27ae60')
    
    # External Services
    draw_box(ax, 2, 3, 2.5, 0.8, 'Firebase\n(Notifications)', '#f39c12')
    draw_box(ax, 7, 3, 2.5, 0.8, 'Garmin/Strava\n(Device Sync)', '#8e44ad')
    draw_box(ax, 12, 3, 2.5, 0.8, 'Email Service\n(SES)', '#2980b9')
    
    # CDN
    draw_box(ax, 7, 1.5, 4, 0.8, 'CloudFront CDN', '#16a085')
    
    # Arrows
    draw_arrow(ax, 2, 8.6, 5.5, 7.9)
    draw_arrow(ax, 7, 8.6, 7, 7.9)
    draw_arrow(ax, 12, 8.6, 8.5, 7.9)
    
    draw_arrow(ax, 5, 7.1, 2, 6.4)
    draw_arrow(ax, 7, 7.1, 7, 6.4)
    draw_arrow(ax, 9, 7.1, 12, 6.4)
    
    draw_arrow(ax, 2, 5.6, 2, 4.9)
    draw_arrow(ax, 7, 5.6, 7, 4.9)
    draw_arrow(ax, 12, 5.6, 12, 4.9)
    
    draw_arrow(ax, 2, 4.1, 2, 3.4)
    draw_arrow(ax, 7, 4.1, 7, 3.4)
    draw_arrow(ax, 12, 4.1, 12, 3.4)
    
    # Layer labels
    ax.text(0.5, 9, 'Client\nLayer', fontsize=10, fontweight='bold', rotation=90)
    ax.text(0.5, 7.5, 'Gateway\nLayer', fontsize=10, fontweight='bold', rotation=90)
    ax.text(0.5, 6, 'Service\nLayer', fontsize=10, fontweight='bold', rotation=90)
    ax.text(0.5, 4.5, 'Data\nLayer', fontsize=10, fontweight='bold', rotation=90)
    ax.text(0.5, 3, 'External\nServices', fontsize=10, fontweight='bold', rotation=90)
    
    save_diagram(fig, '01_system_architecture.png')

# ============================================================
# 2. DATABASE ER DIAGRAM
# ============================================================
def create_database_er():
    fig, ax = plt.subplots(1, 1, figsize=(16, 12))
    ax.set_xlim(0, 16)
    ax.set_ylim(0, 12)
    ax.axis('off')
    ax.set_title('Veltrix Sports - Database ER Diagram', fontsize=16, fontweight='bold', pad=20)
    
    # Users table
    draw_box(ax, 2, 10, 3, 1.2, 'users\n─────────\nid (PK)\nemail\nphone\nname\nrole\npassword_hash', '#3498db', 'white', 8)
    
    # Training Plans
    draw_box(ax, 6, 10, 3, 1.2, 'training_plans\n─────────\nid (PK)\nuser_id (FK)\ntitle\nsport\nduration\nstatus', '#2ecc71', 'white', 8)
    
    # Plan Sessions
    draw_box(ax, 10, 10, 3, 1.2, 'plan_sessions\n─────────\nid (PK)\nplan_id (FK)\nweek_id (FK)\nsession_type\nduration\ndistance', '#e74c3c', 'white', 8)
    
    # Session Logs
    draw_box(ax, 14, 10, 3, 1.2, 'session_logs\n─────────\nid (PK)\nsession_id (FK)\nuser_id (FK)\nactual_duration\nactual_distance\nstatus', '#9b59b6', 'white', 8)
    
    # Events
    draw_box(ax, 2, 7, 3, 1.2, 'events\n─────────\nid (PK)\norganizer_id (FK)\ntitle\nsport\nevent_date\ncity\nstatus', '#f39c12', 'white', 8)
    
    # Event Categories
    draw_box(ax, 6, 7, 3, 1.2, 'event_categories\n─────────\nid (PK)\nevent_id (FK)\nname\ndistance\nprice\nmax_participants', '#1abc9c', 'white', 8)
    
    # Registrations
    draw_box(ax, 10, 7, 3, 1.2, 'event_registrations\n─────────\nid (PK)\nevent_id (FK)\nuser_id (FK)\ncategory_id (FK)\nbib_number\nstatus', '#e67e22', 'white', 8)
    
    # Tickets
    draw_box(ax, 14, 7, 3, 1.2, 'tickets\n─────────\nid (PK)\nevent_id (FK)\nregistration_id (FK)\nticket_code\nqr_code\nstatus', '#c0392b', 'white', 8)
    
    # Devices
    draw_box(ax, 2, 4, 3, 1.2, 'devices\n─────────\nid (PK)\nuser_id (FK)\nprovider\ndevice_name\naccess_token\nstatus', '#16a085', 'white', 8)
    
    # Payments
    draw_box(ax, 6, 4, 3, 1.2, 'payments\n─────────\nid (PK)\nuser_id (FK)\norder_id\namount\ncurrency\nstatus\nprovider', '#8e44ad', 'white', 8)
    
    # Notifications
    draw_box(ax, 10, 4, 3, 1.2, 'notifications\n─────────\nid (PK)\nuser_id (FK)\ntype\ntitle\nmessage\nis_read', '#2c3e50', 'white', 8)
    
    # Reviews
    draw_box(ax, 14, 4, 3, 1.2, 'reviews\n─────────\nid (PK)\nevent_id (FK)\nuser_id (FK)\nrating\ntitle\ncomment', '#d35400', 'white', 8)
    
    # Relationships
    draw_arrow(ax, 3.5, 10, 4.5, 10, '1:N')
    draw_arrow(ax, 7.5, 10, 8.5, 10, '1:N')
    draw_arrow(ax, 11.5, 10, 12.5, 10, '1:N')
    
    draw_arrow(ax, 3.5, 7, 4.5, 7, '1:N')
    draw_arrow(ax, 7.5, 7, 8.5, 7, '1:N')
    draw_arrow(ax, 11.5, 7, 12.5, 7, '1:1')
    
    draw_arrow(ax, 2, 8.8, 2, 7.6, '1:N')
    draw_arrow(ax, 6, 8.8, 6, 7.6, '1:N')
    
    draw_arrow(ax, 2, 5.6, 2, 4.6, '1:N')
    draw_arrow(ax, 6, 5.6, 6, 4.6, '1:N')
    draw_arrow(ax, 10, 5.6, 10, 4.6, '1:N')
    draw_arrow(ax, 14, 5.6, 14, 4.6, '1:N')
    
    save_diagram(fig, '02_database_er.png')

# ============================================================
# 3. USER AUTHENTICATION FLOW
# ============================================================
def create_auth_flow():
    fig, ax = plt.subplots(1, 1, figsize=(12, 14))
    ax.set_xlim(0, 12)
    ax.set_ylim(0, 14)
    ax.axis('off')
    ax.set_title('Veltrix Sports - Authentication Flow', fontsize=16, fontweight='bold', pad=20)
    
    # Start
    draw_box(ax, 6, 13, 3, 0.7, 'User Opens App', '#2c3e50')
    
    # Decision
    draw_box(ax, 6, 11.5, 3, 0.7, 'Has Account?', '#f39c12', 'black')
    
    # Login path
    draw_box(ax, 3, 10, 2.5, 0.7, 'Login Screen', '#3498db')
    draw_box(ax, 3, 8.5, 2.5, 0.7, 'Enter Credentials', '#3498db')
    draw_box(ax, 3, 7, 2.5, 0.7, 'Validate Input', '#9b59b6')
    
    # Validation decision
    draw_box(ax, 3, 5.5, 2.5, 0.7, 'Valid?', '#f39c12', 'black')
    
    # API call
    draw_box(ax, 3, 4, 2.5, 0.7, 'POST /auth/login', '#1abc9c')
    
    # Response decision
    draw_box(ax, 3, 2.5, 2.5, 0.7, 'Success?', '#f39c12', 'black')
    
    # Success
    draw_box(ax, 1.5, 1, 2, 0.7, 'Store Token', '#2ecc71')
    draw_box(ax, 4.5, 1, 2, 0.7, 'Navigate to\nDashboard', '#2ecc71')
    
    # Register path
    draw_box(ax, 9, 10, 2.5, 0.7, 'Register Screen', '#e74c3c')
    draw_box(ax, 9, 8.5, 2.5, 0.7, 'Enter Details', '#e74c3c')
    draw_box(ax, 9, 7, 2.5, 0.7, 'Send OTP', '#9b59b6')
    draw_box(ax, 9, 5.5, 2.5, 0.7, 'Verify OTP', '#9b59b6')
    draw_box(ax, 9, 4, 2.5, 0.7, 'POST /auth/register', '#1abc9c')
    draw_box(ax, 9, 2.5, 2.5, 0.7, 'Account Created', '#2ecc71')
    
    # Arrows
    draw_arrow(ax, 6, 12.6, 6, 11.9)
    draw_arrow(ax, 4.5, 11.5, 3, 11.1)
    draw_arrow(ax, 7.5, 11.5, 9, 11.1)
    
    draw_arrow(ax, 3, 10.4, 3, 10.4)
    draw_arrow(ax, 3, 9.6, 3, 8.9)
    draw_arrow(ax, 3, 8.1, 3, 7.4)
    draw_arrow(ax, 3, 6.6, 3, 5.9)
    
    draw_arrow(ax, 3, 5.1, 3, 4.4)
    draw_arrow(ax, 3, 3.6, 3, 2.9)
    
    draw_arrow(ax, 2, 2.1, 1.5, 1.4)
    draw_arrow(ax, 4, 2.1, 4.5, 1.4)
    
    draw_arrow(ax, 9, 10.4, 9, 10.4)
    draw_arrow(ax, 9, 9.6, 9, 8.9)
    draw_arrow(ax, 9, 8.1, 9, 7.4)
    draw_arrow(ax, 9, 6.6, 9, 5.9)
    draw_arrow(ax, 9, 5.1, 9, 4.4)
    draw_arrow(ax, 9, 3.6, 9, 2.9)
    
    # Error paths
    draw_box(ax, 1, 4, 2, 0.5, 'Show Error', '#e74c3c', 'white', 8)
    draw_arrow(ax, 1.5, 5.5, 1, 4.3)
    
    save_diagram(fig, '03_authentication_flow.png')

# ============================================================
# 4. TRAINING PLAN FLOW
# ============================================================
def create_training_flow():
    fig, ax = plt.subplots(1, 1, figsize=(12, 14))
    ax.set_xlim(0, 12)
    ax.set_ylim(0, 14)
    ax.axis('off')
    ax.set_title('Veltrix Sports - Training Plan Flow', fontsize=16, fontweight='bold', pad=20)
    
    # Start
    draw_box(ax, 6, 13, 3, 0.7, 'Athlete Opens App', '#2c3e50')
    
    # Main menu
    draw_box(ax, 6, 11.5, 3, 0.7, 'Training Plans', '#3498db')
    
    # Options
    draw_box(ax, 3, 10, 2.5, 0.7, 'View Existing\nPlans', '#2ecc71')
    draw_box(ax, 9, 10, 2.5, 0.7, 'Create New\nPlan', '#e74c3c')
    
    # View plan flow
    draw_box(ax, 3, 8.5, 2.5, 0.7, 'Select Plan', '#3498db')
    draw_box(ax, 3, 7, 2.5, 0.7, 'View Plan\nDetails', '#3498db')
    draw_box(ax, 3, 5.5, 2.5, 0.7, 'Select Session', '#9b59b6')
    draw_box(ax, 3, 4, 2.5, 0.7, 'Start Session', '#1abc9c')
    draw_box(ax, 3, 2.5, 2.5, 0.7, 'Complete\nSession', '#2ecc71')
    draw_box(ax, 3, 1, 2.5, 0.7, 'Log Results', '#f39c12')
    
    # Create plan flow
    draw_box(ax, 9, 8.5, 2.5, 0.7, 'Select Sport', '#e74c3c')
    draw_box(ax, 9, 7, 2.5, 0.7, 'Select Goal', '#e74c3c')
    draw_box(ax, 9, 5.5, 2.5, 0.7, 'AI Generate\nor Manual?', '#9b59b6')
    
    # AI path
    draw_box(ax, 7, 4, 2, 0.7, 'AI Generate', '#8e44ad')
    draw_box(ax, 10, 4, 2, 0.7, 'Manual Create', '#8e44ad')
    
    draw_box(ax, 9, 2.5, 2.5, 0.7, 'Review Plan', '#f39c12')
    draw_box(ax, 9, 1, 2.5, 0.7, 'Save Plan', '#2ecc71')
    
    # Arrows
    draw_arrow(ax, 6, 12.6, 6, 11.9)
    draw_arrow(ax, 4.5, 11.5, 3, 10.4)
    draw_arrow(ax, 7.5, 11.5, 9, 10.4)
    
    draw_arrow(ax, 3, 9.6, 3, 8.9)
    draw_arrow(ax, 3, 8.1, 3, 7.4)
    draw_arrow(ax, 3, 6.6, 3, 5.9)
    draw_arrow(ax, 3, 5.1, 3, 4.4)
    draw_arrow(ax, 3, 3.6, 3, 2.9)
    draw_arrow(ax, 3, 2.1, 3, 1.4)
    
    draw_arrow(ax, 9, 9.6, 9, 8.9)
    draw_arrow(ax, 9, 8.1, 9, 7.4)
    draw_arrow(ax, 9, 6.6, 9, 5.9)
    draw_arrow(ax, 7.5, 5.5, 7, 4.4)
    draw_arrow(ax, 10.5, 5.5, 10, 4.4)
    draw_arrow(ax, 9, 3.6, 9, 2.9)
    draw_arrow(ax, 9, 2.1, 9, 1.4)
    
    save_diagram(fig, '04_training_plan_flow.png')

# ============================================================
# 5. EVENT REGISTRATION FLOW
# ============================================================
def create_event_flow():
    fig, ax = plt.subplots(1, 1, figsize=(12, 14))
    ax.set_xlim(0, 12)
    ax.set_ylim(0, 14)
    ax.axis('off')
    ax.set_title('Veltrix Sports - Event Registration Flow', fontsize=16, fontweight='bold', pad=20)
    
    # Start
    draw_box(ax, 6, 13, 3, 0.7, 'User Browses Events', '#2c3e50')
    
    # Discovery
    draw_box(ax, 6, 11.5, 3, 0.7, 'View Event List', '#3498db')
    draw_box(ax, 6, 10, 3, 0.7, 'Select Event', '#3498db')
    draw_box(ax, 6, 8.5, 3, 0.7, 'View Event Details', '#3498db')
    
    # Decision
    draw_box(ax, 6, 7, 3, 0.7, 'Register?', '#f39c12', 'black')
    
    # Registration
    draw_box(ax, 6, 5.5, 3, 0.7, 'Select Category', '#9b59b6')
    draw_box(ax, 6, 4, 3, 0.7, 'Fill Registration\nForm', '#e74c3c')
    draw_box(ax, 6, 2.5, 3, 0.7, 'Proceed to\nPayment', '#1abc9c')
    
    # Payment
    draw_box(ax, 6, 1, 3, 0.7, 'Complete Payment\n(Razorpay)', '#8e44ad')
    
    # Confirmation
    draw_box(ax, 9, 1, 2.5, 0.7, 'Receive\nConfirmation', '#2ecc71')
    draw_box(ax, 9, 2.5, 2.5, 0.7, 'Get Ticket\n& BIB Number', '#2ecc71')
    draw_box(ax, 9, 4, 2.5, 0.7, 'Add to\nCalendar', '#2ecc71')
    
    # Arrows
    draw_arrow(ax, 6, 12.6, 6, 11.9)
    draw_arrow(ax, 6, 11.1, 6, 10.4)
    draw_arrow(ax, 6, 9.6, 6, 8.9)
    draw_arrow(ax, 6, 8.1, 6, 7.4)
    draw_arrow(ax, 6, 6.6, 6, 5.9)
    draw_arrow(ax, 6, 5.1, 6, 4.4)
    draw_arrow(ax, 6, 3.6, 6, 2.9)
    draw_arrow(ax, 6, 2.1, 6, 1.4)
    
    draw_arrow(ax, 7.5, 1, 8.5, 1)
    draw_arrow(ax, 9, 1.4, 9, 2.1)
    draw_arrow(ax, 9, 2.9, 9, 3.6)
    
    save_diagram(fig, '05_event_registration_flow.png')

# ============================================================
# 6. PAYMENT FLOW
# ============================================================
def create_payment_flow():
    fig, ax = plt.subplots(1, 1, figsize=(12, 14))
    ax.set_xlim(0, 12)
    ax.set_ylim(0, 14)
    ax.axis('off')
    ax.set_title('Veltrix Sports - Payment Flow', fontsize=16, fontweight='bold', pad=20)
    
    # Start
    draw_box(ax, 6, 13, 3, 0.7, 'User Proceeds\nto Payment', '#2c3e50')
    
    # Create order
    draw_box(ax, 6, 11.5, 3, 0.7, 'POST /payments/create', '#3498db')
    draw_box(ax, 6, 10, 3, 0.7, 'Generate\nRazorpay Order', '#9b59b6')
    
    # Razorpay
    draw_box(ax, 6, 8.5, 3, 0.7, 'Open Razorpay\nCheckout', '#8e44ad')
    
    # Payment methods
    draw_box(ax, 2, 7, 2.5, 0.7, 'Credit/Debit\nCard', '#e74c3c')
    draw_box(ax, 6, 7, 2.5, 0.7, 'UPI', '#2ecc71')
    draw_box(ax, 10, 7, 2.5, 0.7, 'Net Banking', '#f39c12')
    
    # Process
    draw_box(ax, 6, 5.5, 3, 0.7, 'Process Payment\n(Razorpay)', '#1abc9c')
    
    # Decision
    draw_box(ax, 6, 4, 3, 0.7, 'Payment\nSuccessful?', '#f39c12', 'black')
    
    # Success path
    draw_box(ax, 3, 2.5, 2.5, 0.7, 'POST\n/payments/verify', '#3498db')
    draw_box(ax, 3, 1, 2.5, 0.7, 'Verify\nSignature', '#9b59b6')
    
    # Failure path
    draw_box(ax, 9, 2.5, 2.5, 0.7, 'Show Error\nMessage', '#e74c3c')
    draw_box(ax, 9, 1, 2.5, 0.7, 'Retry\nPayment', '#e74c3c')
    
    # Final success
    draw_box(ax, 3, -0.5, 2.5, 0.7, 'Payment\nCaptured', '#2ecc71')
    draw_box(ax, 6, -0.5, 2.5, 0.7, 'Send\nConfirmation', '#2ecc71')
    draw_box(ax, 9, -0.5, 2.5, 0.7, 'Generate\nTicket', '#2ecc71')
    
    # Arrows
    draw_arrow(ax, 6, 12.6, 6, 11.9)
    draw_arrow(ax, 6, 11.1, 6, 10.4)
    draw_arrow(ax, 6, 9.6, 6, 8.9)
    
    draw_arrow(ax, 4.5, 8.5, 2, 7.4)
    draw_arrow(ax, 6, 8.1, 6, 7.4)
    draw_arrow(ax, 7.5, 8.5, 10, 7.4)
    
    draw_arrow(ax, 2, 6.6, 6, 5.9)
    draw_arrow(ax, 6, 6.6, 6, 5.9)
    draw_arrow(ax, 10, 6.6, 6, 5.9)
    
    draw_arrow(ax, 6, 5.1, 6, 4.4)
    draw_arrow(ax, 4.5, 4, 3, 2.9)
    draw_arrow(ax, 7.5, 4, 9, 2.9)
    
    draw_arrow(ax, 3, 2.1, 3, 1.4)
    draw_arrow(ax, 9, 2.1, 9, 1.4)
    
    draw_arrow(ax, 3, 0.6, 3, 0.1)
    draw_arrow(ax, 4.5, 1, 5.5, -0.1)
    draw_arrow(ax, 7.5, 1, 6.5, -0.1)
    
    save_diagram(fig, '06_payment_flow.png')

# ============================================================
# 7. DEVICE SYNC FLOW
# ============================================================
def create_device_sync_flow():
    fig, ax = plt.subplots(1, 1, figsize=(12, 12))
    ax.set_xlim(0, 12)
    ax.set_ylim(0, 12)
    ax.axis('off')
    ax.set_title('Veltrix Sports - Device Sync Flow', fontsize=16, fontweight='bold', pad=20)
    
    # Start
    draw_box(ax, 6, 11, 3, 0.7, 'User Opens\nDevice Settings', '#2c3e50')
    
    # Device selection
    draw_box(ax, 6, 9.5, 3, 0.7, 'Select Device\nProvider', '#3498db')
    
    # Providers
    draw_box(ax, 1.5, 8, 2, 0.7, 'Garmin', '#8e44ad')
    draw_box(ax, 4.5, 8, 2, 0.7, 'Apple\nHealth', '#e74c3c')
    draw_box(ax, 7.5, 8, 2, 0.7, 'Strava', '#f39c12')
    draw_box(ax, 10.5, 8, 2, 0.7, 'Google\nFit', '#2ecc71')
    
    # OAuth
    draw_box(ax, 6, 6.5, 3, 0.7, 'OAuth\nAuthorization', '#9b59b6')
    
    # Permissions
    draw_box(ax, 6, 5, 3, 0.7, 'Grant\nPermissions', '#1abc9c')
    
    # Connect
    draw_box(ax, 6, 3.5, 3, 0.7, 'POST\n/devices/connect', '#3498db')
    
    # Sync
    draw_box(ax, 6, 2, 3, 0.7, 'Sync\nActivities', '#8e44ad')
    
    # Complete
    draw_box(ax, 6, 0.5, 3, 0.7, 'Device Connected\n✓', '#2ecc71')
    
    # Arrows
    draw_arrow(ax, 6, 10.6, 6, 9.9)
    draw_arrow(ax, 6, 9.1, 6, 8.4)
    
    draw_arrow(ax, 4.5, 8, 1.5, 8)
    draw_arrow(ax, 5.5, 8, 4.5, 8)
    draw_arrow(ax, 7.5, 8, 7.5, 8)
    draw_arrow(ax, 8.5, 8, 10.5, 8)
    
    draw_arrow(ax, 1.5, 7.6, 6, 6.9)
    draw_arrow(ax, 4.5, 7.6, 6, 6.9)
    draw_arrow(ax, 7.5, 7.6, 6, 6.9)
    draw_arrow(ax, 10.5, 7.6, 6, 6.9)
    
    draw_arrow(ax, 6, 6.1, 6, 5.4)
    draw_arrow(ax, 6, 4.6, 6, 3.9)
    draw_arrow(ax, 6, 3.1, 6, 2.4)
    draw_arrow(ax, 6, 1.6, 6, 0.9)
    
    save_diagram(fig, '07_device_sync_flow.png')

# ============================================================
# 8. FEATURE MODULE DIAGRAM
# ============================================================
def create_feature_modules():
    fig, ax = plt.subplots(1, 1, figsize=(14, 10))
    ax.set_xlim(0, 14)
    ax.set_ylim(0, 10)
    ax.axis('off')
    ax.set_title('Veltrix Sports - Feature Modules', fontsize=16, fontweight='bold', pad=20)
    
    # Main App
    draw_box(ax, 7, 9, 4, 0.8, 'Veltrix Sports App', '#2c3e50')
    
    # Modules
    draw_box(ax, 2, 7, 2.5, 0.8, 'Authentication\nModule', '#e74c3c')
    draw_box(ax, 5.5, 7, 2.5, 0.8, 'Training Plan\nModule', '#3498db')
    draw_box(ax, 9, 7, 2.5, 0.8, 'Events\nModule', '#2ecc71')
    draw_box(ax, 12.5, 7, 2.5, 0.8, 'Ticketing\nModule', '#f39c12')
    
    draw_box(ax, 2, 5, 2.5, 0.8, 'Profile\nModule', '#9b59b6')
    draw_box(ax, 5.5, 5, 2.5, 0.8, 'Device Sync\nModule', '#1abc9c')
    draw_box(ax, 9, 5, 2.5, 0.8, 'Payment\nModule', '#e67e22')
    draw_box(ax, 12.5, 5, 2.5, 0.8, 'Notification\nModule', '#c0392b')
    
    # Sub-features
    draw_box(ax, 1, 3, 2, 0.6, 'Register', '#34495e', 'white', 8)
    draw_box(ax, 3, 3, 2, 0.6, 'Login', '#34495e', 'white', 8)
    draw_box(ax, 5, 3, 2, 0.6, 'View Plans', '#34495e', 'white', 8)
    draw_box(ax, 7, 3, 2, 0.6, 'Create Plan', '#34495e', 'white', 8)
    draw_box(ax, 9, 3, 2, 0.6, 'Browse Events', '#34495e', 'white', 8)
    draw_box(ax, 11, 3, 2, 0.6, 'Register Event', '#34495e', 'white', 8)
    draw_box(ax, 13, 3, 2, 0.6, 'Buy Tickets', '#34495e', 'white', 8)
    
    draw_box(ax, 1, 1.5, 2, 0.6, 'Edit Profile', '#34495e', 'white', 8)
    draw_box(ax, 3, 1.5, 2, 0.6, 'Connect Device', '#34495e', 'white', 8)
    draw_box(ax, 5, 1.5, 2, 0.6, 'Process Payment', '#34495e', 'white', 8)
    draw_box(ax, 7, 1.5, 2, 0.6, 'Send Push', '#34495e', 'white', 8)
    draw_box(ax, 9, 1.5, 2, 0.6, 'Sync Data', '#34495e', 'white', 8)
    draw_box(ax, 11, 1.5, 2, 0.6, 'Track Progress', '#34495e', 'white', 8)
    draw_box(ax, 13, 1.5, 2, 0.6, 'Manage Tickets', '#34495e', 'white', 8)
    
    # Arrows
    draw_arrow(ax, 4.5, 8.6, 2, 7.4)
    draw_arrow(ax, 5.5, 8.6, 5.5, 7.4)
    draw_arrow(ax, 7, 8.6, 9, 7.4)
    draw_arrow(ax, 9.5, 8.6, 12.5, 7.4)
    
    draw_arrow(ax, 4.5, 8.6, 2, 5.4)
    draw_arrow(ax, 5.5, 8.6, 5.5, 5.4)
    draw_arrow(ax, 7, 8.6, 9, 5.4)
    draw_arrow(ax, 9.5, 8.6, 12.5, 5.4)
    
    draw_arrow(ax, 2, 6.6, 1, 3.3)
    draw_arrow(ax, 2, 6.6, 3, 3.3)
    draw_arrow(ax, 5.5, 6.6, 5, 3.3)
    draw_arrow(ax, 5.5, 6.6, 7, 3.3)
    draw_arrow(ax, 9, 6.6, 9, 3.3)
    draw_arrow(ax, 9, 6.6, 11, 3.3)
    draw_arrow(ax, 12.5, 6.6, 13, 3.3)
    
    draw_arrow(ax, 2, 4.6, 1, 1.8)
    draw_arrow(ax, 2, 4.6, 3, 1.8)
    draw_arrow(ax, 5.5, 4.6, 5, 1.8)
    draw_arrow(ax, 5.5, 4.6, 7, 1.8)
    draw_arrow(ax, 9, 4.6, 9, 1.8)
    draw_arrow(ax, 9, 4.6, 11, 1.8)
    draw_arrow(ax, 12.5, 4.6, 13, 1.8)
    
    save_diagram(fig, '08_feature_modules.png')

# ============================================================
# 9. API ENDPOINTS DIAGRAM
# ============================================================
def create_api_endpoints():
    fig, ax = plt.subplots(1, 1, figsize=(14, 10))
    ax.set_xlim(0, 14)
    ax.set_ylim(0, 10)
    ax.axis('off')
    ax.set_title('Veltrix Sports - API Endpoints', fontsize=16, fontweight='bold', pad=20)
    
    # Auth endpoints
    draw_box(ax, 2, 9, 2.5, 0.8, 'Auth Endpoints', '#e74c3c')
    draw_box(ax, 2, 8, 2, 0.5, 'POST /register', '#34495e', 'white', 7)
    draw_box(ax, 2, 7.4, 2, 0.5, 'POST /login', '#34495e', 'white', 7)
    draw_box(ax, 2, 6.8, 2, 0.5, 'POST /otp/send', '#34495e', 'white', 7)
    draw_box(ax, 2, 6.2, 2, 0.5, 'POST /otp/verify', '#34495e', 'white', 7)
    
    # User endpoints
    draw_box(ax, 5, 9, 2.5, 0.8, 'User Endpoints', '#3498db')
    draw_box(ax, 5, 8, 2, 0.5, 'GET /profile', '#34495e', 'white', 7)
    draw_box(ax, 5, 7.4, 2, 0.5, 'PUT /profile', '#34495e', 'white', 7)
    draw_box(ax, 5, 6.8, 2, 0.5, 'POST /avatar', '#34495e', 'white', 7)
    
    # Plan endpoints
    draw_box(ax, 8, 9, 2.5, 0.8, 'Training Endpoints', '#2ecc71')
    draw_box(ax, 8, 8, 2, 0.5, 'GET /plans', '#34495e', 'white', 7)
    draw_box(ax, 8, 7.4, 2, 0.5, 'POST /plans', '#34495e', 'white', 7)
    draw_box(ax, 8, 6.8, 2, 0.5, 'GET /plans/:id', '#34495e', 'white', 7)
    draw_box(ax, 8, 6.2, 2, 0.5, 'POST /sessions', '#34495e', 'white', 7)
    
    # Event endpoints
    draw_box(ax, 11, 9, 2.5, 0.8, 'Event Endpoints', '#f39c12')
    draw_box(ax, 11, 8, 2, 0.5, 'GET /events', '#34495e', 'white', 7)
    draw_box(ax, 11, 7.4, 2, 0.5, 'POST /events', '#34495e', 'white', 7)
    draw_box(ax, 11, 6.8, 2, 0.5, 'POST /register', '#34495e', 'white', 7)
    draw_box(ax, 11, 6.2, 2, 0.5, 'GET /tickets', '#34495e', 'white', 7)
    
    # Payment endpoints
    draw_box(ax, 2, 5, 2.5, 0.8, 'Payment Endpoints', '#9b59b6')
    draw_box(ax, 2, 4, 2, 0.5, 'POST /create', '#34495e', 'white', 7)
    draw_box(ax, 2, 3.4, 2, 0.5, 'POST /verify', '#34495e', 'white', 7)
    draw_box(ax, 2, 2.8, 2, 0.5, 'GET /history', '#34495e', 'white', 7)
    
    # Device endpoints
    draw_box(ax, 5, 5, 2.5, 0.8, 'Device Endpoints', '#1abc9c')
    draw_box(ax, 5, 4, 2, 0.5, 'POST /connect', '#34495e', 'white', 7)
    draw_box(ax, 5, 3.4, 2, 0.5, 'POST /sync', '#34495e', 'white', 7)
    draw_box(ax, 5, 2.8, 2, 0.5, 'DELETE /device', '#34495e', 'white', 7)
    
    # Admin endpoints
    draw_box(ax, 8, 5, 2.5, 0.8, 'Admin Endpoints', '#e67e22')
    draw_box(ax, 8, 4, 2, 0.5, 'GET /users', '#34495e', 'white', 7)
    draw_box(ax, 8, 3.4, 2, 0.5, 'GET /analytics', '#34495e', 'white', 7)
    draw_box(ax, 8, 2.8, 2, 0.5, 'POST /events', '#34495e', 'white', 7)
    
    # Base URL
    draw_box(ax, 11, 5, 2.5, 0.8, 'Base URL', '#2c3e50')
    draw_box(ax, 11, 4, 2.5, 0.6, 'https://api.\nveltrixsports.com/v1', '#34495e', 'white', 8)
    
    # Arrows
    draw_arrow(ax, 2, 8.6, 2, 8.4)
    draw_arrow(ax, 5, 8.6, 5, 8.4)
    draw_arrow(ax, 8, 8.6, 8, 8.4)
    draw_arrow(ax, 11, 8.6, 11, 8.4)
    draw_arrow(ax, 2, 5.4, 2, 4.4)
    draw_arrow(ax, 5, 5.4, 5, 4.4)
    draw_arrow(ax, 8, 5.4, 8, 4.4)
    
    save_diagram(fig, '09_api_endpoints.png')

# ============================================================
# 10. SCREEN NAVIGATION DIAGRAM
# ============================================================
def create_screen_navigation():
    fig, ax = plt.subplots(1, 1, figsize=(14, 10))
    ax.set_xlim(0, 14)
    ax.set_ylim(0, 10)
    ax.axis('off')
    ax.set_title('Veltrix Sports - Screen Navigation', fontsize=16, fontweight='bold', pad=20)
    
    # Auth screens
    draw_box(ax, 2, 9, 2.5, 0.7, 'Splash Screen', '#2c3e50')
    draw_box(ax, 2, 7.5, 2.5, 0.7, 'Login Screen', '#e74c3c')
    draw_box(ax, 2, 6, 2.5, 0.7, 'Register Screen', '#e74c3c')
    draw_box(ax, 2, 4.5, 2.5, 0.7, 'OTP Screen', '#e74c3c')
    
    # Main screens
    draw_box(ax, 7, 9, 2.5, 0.7, 'Dashboard', '#3498db')
    draw_box(ax, 7, 7.5, 2.5, 0.7, 'Training Plans', '#2ecc71')
    draw_box(ax, 7, 6, 2.5, 0.7, 'Events', '#f39c12')
    draw_box(ax, 7, 4.5, 2.5, 0.7, 'Tickets', '#9b59b6')
    draw_box(ax, 7, 3, 2.5, 0.7, 'Profile', '#1abc9c')
    
    # Detail screens
    draw_box(ax, 12, 9, 2.5, 0.7, 'Plan Detail', '#34495e')
    draw_box(ax, 12, 7.5, 2.5, 0.7, 'Session Detail', '#34495e')
    draw_box(ax, 12, 6, 2.5, 0.7, 'Event Detail', '#34495e')
    draw_box(ax, 12, 4.5, 2.5, 0.7, 'Ticket Detail', '#34495e')
    draw_box(ax, 12, 3, 2.5, 0.7, 'Settings', '#34495e')
    
    # Bottom nav
    draw_box(ax, 7, 1.5, 6, 0.7, 'Bottom Navigation Bar', '#2c3e50')
    
    # Arrows
    draw_arrow(ax, 2, 8.6, 2, 7.9)
    draw_arrow(ax, 2, 7.1, 2, 6.4)
    draw_arrow(ax, 2, 5.6, 2, 4.9)
    
    draw_arrow(ax, 3.5, 7.5, 5.5, 9)
    draw_arrow(ax, 3.5, 6, 5.5, 9)
    
    draw_arrow(ax, 7, 8.6, 7, 7.9)
    draw_arrow(ax, 7, 7.1, 7, 6.4)
    draw_arrow(ax, 7, 5.6, 7, 4.9)
    draw_arrow(ax, 7, 4.1, 7, 3.4)
    
    draw_arrow(ax, 8.5, 7.5, 10.5, 9)
    draw_arrow(ax, 8.5, 6, 10.5, 7.5)
    draw_arrow(ax, 8.5, 4.5, 10.5, 6)
    draw_arrow(ax, 8.5, 3, 10.5, 4.5)
    
    draw_arrow(ax, 5, 1.5, 7, 2.6)
    draw_arrow(ax, 9, 1.5, 7, 2.6)
    
    save_diagram(fig, '10_screen_navigation.png')

# ============================================================
# 11. DATA FLOW DIAGRAM
# ============================================================
def create_data_flow():
    fig, ax = plt.subplots(1, 1, figsize=(14, 10))
    ax.set_xlim(0, 14)
    ax.set_ylim(0, 10)
    ax.axis('off')
    ax.set_title('Veltrix Sports - Data Flow Diagram', fontsize=16, fontweight='bold', pad=20)
    
    # External entities
    draw_box(ax, 2, 9, 2.5, 0.7, 'User', '#2c3e50')
    draw_box(ax, 2, 7, 2.5, 0.7, 'Device\n(Garmin/Apple)', '#8e44ad')
    draw_box(ax, 2, 5, 2.5, 0.7, 'Payment\nGateway', '#e74c3c')
    
    # Processes
    draw_box(ax, 7, 9, 2.5, 0.7, 'Authentication\nProcess', '#3498db')
    draw_box(ax, 7, 7.5, 2.5, 0.7, 'Training\nProcess', '#2ecc71')
    draw_box(ax, 7, 6, 2.5, 0.7, 'Event\nProcess', '#f39c12')
    draw_box(ax, 7, 4.5, 2.5, 0.7, 'Payment\nProcess', '#9b59b6')
    draw_box(ax, 7, 3, 2.5, 0.7, 'Device Sync\nProcess', '#1abc9c')
    
    # Data stores
    draw_box(ax, 12, 9, 2.5, 0.7, 'Users\nDatabase', '#34495e')
    draw_box(ax, 12, 7.5, 2.5, 0.7, 'Plans\nDatabase', '#34495e')
    draw_box(ax, 12, 6, 2.5, 0.7, 'Events\nDatabase', '#34495e')
    draw_box(ax, 12, 4.5, 2.5, 0.7, 'Payments\nDatabase', '#34495e')
    draw_box(ax, 12, 3, 2.5, 0.7, 'Devices\nDatabase', '#34495e')
    
    # Arrows
    draw_arrow(ax, 3.5, 9, 5.5, 9, 'Login')
    draw_arrow(ax, 3.5, 7, 5.5, 7.5, 'Sync Data')
    draw_arrow(ax, 3.5, 5, 5.5, 4.5, 'Process')
    
    draw_arrow(ax, 8.5, 9, 10.5, 9, 'Store')
    draw_arrow(ax, 8.5, 7.5, 10.5, 7.5, 'Store')
    draw_arrow(ax, 8.5, 6, 10.5, 6, 'Store')
    draw_arrow(ax, 8.5, 4.5, 10.5, 4.5, 'Store')
    draw_arrow(ax, 8.5, 3, 10.5, 3, 'Store')
    
    draw_arrow(ax, 7, 8.6, 7, 7.9)
    draw_arrow(ax, 7, 7.1, 7, 6.4)
    draw_arrow(ax, 7, 5.6, 7, 4.9)
    draw_arrow(ax, 7, 4.1, 7, 3.4)
    
    save_diagram(fig, '11_data_flow.png')

# ============================================================
# 12. DEPLOYMENT ARCHITECTURE
# ============================================================
def create_deployment_architecture():
    fig, ax = plt.subplots(1, 1, figsize=(14, 10))
    ax.set_xlim(0, 14)
    ax.set_ylim(0, 10)
    ax.axis('off')
    ax.set_title('Veltrix Sports - Deployment Architecture', fontsize=16, fontweight='bold', pad=20)
    
    # Users
    draw_box(ax, 2, 9, 2.5, 0.7, 'Mobile Users', '#2c3e50')
    draw_box(ax, 2, 7.5, 2.5, 0.7, 'Web Users', '#2c3e50')
    
    # CDN
    draw_box(ax, 7, 9, 2.5, 0.7, 'CloudFront\nCDN', '#16a085')
    
    # Load Balancer
    draw_box(ax, 7, 7.5, 2.5, 0.7, 'Application\nLoad Balancer', '#e67e22')
    
    # EC2
    draw_box(ax, 5, 6, 2, 0.7, 'EC2\nInstance 1', '#3498db')
    draw_box(ax, 9, 6, 2, 0.7, 'EC2\nInstance 2', '#3498db')
    
    # Database
    draw_box(ax, 5, 4, 2, 0.7, 'RDS\nPrimary', '#2c3e50')
    draw_box(ax, 9, 4, 2, 0.7, 'RDS\nStandby', '#2c3e50')
    
    # Cache
    draw_box(ax, 7, 2.5, 2.5, 0.7, 'ElastiCache\nRedis', '#c0392b')
    
    # Storage
    draw_box(ax, 12, 6, 2, 0.7, 'S3\nBucket', '#27ae60')
    
    # External
    draw_box(ax, 12, 4, 2, 0.7, 'Razorpay', '#e74c3c')
    draw_box(ax, 12, 2.5, 2, 0.7, 'Firebase', '#f39c12')
    
    # Arrows
    draw_arrow(ax, 3.5, 9, 5.5, 9)
    draw_arrow(ax, 3.5, 7.5, 5.5, 7.5)
    
    draw_arrow(ax, 7, 8.6, 7, 7.9)
    
    draw_arrow(ax, 5.5, 7.5, 5, 6.4)
    draw_arrow(ax, 8.5, 7.5, 9, 6.4)
    
    draw_arrow(ax, 5, 5.6, 5, 4.4)
    draw_arrow(ax, 9, 5.6, 9, 4.4)
    
    draw_arrow(ax, 7, 5.6, 7, 2.9)
    
    draw_arrow(ax, 5, 5.6, 11, 6)
    draw_arrow(ax, 9, 5.6, 11, 4)
    draw_arrow(ax, 9, 5.6, 11, 2.5)
    
    save_diagram(fig, '12_deployment_architecture.png')

# ============================================================
# RUN ALL DIAGRAMS
# ============================================================
if __name__ == '__main__':
    print("Creating Veltrix Sports Diagrams...")
    print("=" * 50)
    
    create_system_architecture()
    create_database_er()
    create_auth_flow()
    create_training_flow()
    create_event_flow()
    create_payment_flow()
    create_device_sync_flow()
    create_feature_modules()
    create_api_endpoints()
    create_screen_navigation()
    create_data_flow()
    create_deployment_architecture()
    
    print("=" * 50)
    print(f"All diagrams created in: {OUTPUT_DIR}")
    print(f"Total diagrams: 12")

# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

.PHONY: .create-module-app

define APP_STRUCTURE
mkdir -p $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/pages
mkdir -p $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/static
touch $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/{__init__.py,main.py}
touch $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/pages/{data_visualization.py,settings.py}
endef
export APP_STRUCTURE

.create-module-app:
	@echo "Creating app structure and files..."
	@$(APP_STRUCTURE)
	@echo "$$APP_INIT_CONTENT" > $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/__init__.py
	@echo "$$APP_MAIN_CONTENT" > $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/main.py
	@echo "$$APP_DATA_VIZ_CONTENT" > $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/pages/data_visualization.py
	@echo "$$APP_SETTINGS_CONTENT" > $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/pages/settings.py
	@echo "$$APP_STATIC_CSS" > $(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/static/style.css

define APP_INIT_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/__init__.py
from .main import load_css

__all__ = ['load_css']
endef
export APP_INIT_CONTENT

define APP_MAIN_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/main.py
import streamlit as st
from pathlib import Path
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).services import MainService

def load_css():
    css_file = Path(__file__).parent / "static" / "style.css"
    with open(css_file) as f:
        st.markdown(f"<style>{f.read()}</style>", unsafe_allow_html=True)

st.set_page_config(page_title="$(SAUBER_PACKAGE_NAME) Streamlit App", page_icon=":eyeglasses:", layout="wide")
st.markdown("""
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    """, unsafe_allow_html=True)
load_css()

st.title("$(SAUBER_PACKAGE_NAME) Streamlit App")

col1, col2 = st.columns(2)

with col1:
    st.subheader("Welcome")
    st.write("This app demonstrates Material Design-inspired UI elements in Streamlit.")

    service = MainService()
    st.info(service.main_function())

    if st.button("Click me!"):
        st.success("You clicked the button!")

with col2:
    st.subheader("User Input")
    user_name = st.text_input("Enter your name")
    user_age = st.slider("Select your age", 0, 100, 25)
    user_color = st.color_picker("Choose your favorite color")

    if st.button("Submit"):
        st.write(f"Hello, {user_name}!")
        st.write(f"You are {user_age} years old.")
        st.write(f"Your favorite color is {user_color}")
endef
export APP_MAIN_CONTENT

define APP_DATA_VIZ_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/pages/data_visualization.py
import streamlit as st
import plotly.express as px

st.title("Data Visualization")

# Sample data
data = {
    'x': list(range(10)),
    'y': [i**2 for i in range(10)],
    'size': [10*i for i in range(10)]
}

# Plotly chart
fig = px.scatter(data, x='x', y='y', size='size', color='y',
                 hover_name='x', log_x=True, size_max=60)
fig.update_layout(title='Interactive Scatter Plot')
st.plotly_chart(fig, use_container_width=True)

# Simple table
st.subheader("Data Table")
st.table(data)
endef
export APP_DATA_VIZ_CONTENT

define APP_SETTINGS_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/pages/settings.py
import streamlit as st

st.title("Settings")

st.subheader("App Configuration")
st.toggle("Dark Mode")
st.checkbox("Enable Notifications")
st.select_slider(
    "Update Frequency",
    options=["Hourly", "Daily", "Weekly", "Monthly"]
)

st.subheader("Profile")
st.file_uploader("Upload Profile Picture", type=["jpg", "png", "jpeg"])
st.text_area("Bio", max_chars=200)

if st.button("Save Settings"):
    st.success("Settings saved successfully!")
endef
export APP_SETTINGS_CONTENT

define APP_STATIC_CSS
/* src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/app/static/style.css */
body {
    font-family: 'Roboto', sans-serif;
    background-color: #FAFAFA;
    color: #212121;
}

.stApp {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
}

h1 {
    color: #1976D2;
    font-weight: 300;
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.stButton > button {
    background-color: #2196F3;
    color: white;
    border: none;
    border-radius: 4px;
    padding: 0.5rem 1rem;
    font-size: 1rem;
    font-weight: 500;
    text-transform: uppercase;
    box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16), 0 2px 10px 0 rgba(0,0,0,0.12);
    transition: background-color 0.3s ease;
}

.stButton > button:hover {
    background-color: #1E88E5;
}

.stTextInput > div > div > input {
    border-radius: 4px;
    border: 1px solid #BDBDBD;
    padding: 0.5rem;
    font-size: 1rem;
}

.stTextInput > div > div > input:focus {
    border-color: #2196F3;
    box-shadow: 0 0 0 1px #2196F3;
}

.stSelectbox > div > div > select {
    border-radius: 4px;
    border: 1px solid #BDBDBD;
    padding: 0.5rem;
    font-size: 1rem;
}

.stSelectbox > div > div > select:focus {
    border-color: #2196F3;
    box-shadow: 0 0 0 1px #2196F3;
}

.stDataFrame {
    border: none;
    box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16), 0 2px 10px 0 rgba(0,0,0,0.12);
}

.stDataFrame [data-testid="stTable"] {
    border-collapse: separate;
    border-spacing: 0;
}

.stDataFrame [data-testid="stTable"] th {
    background-color: #E3F2FD;
    color: #1976D2;
    font-weight: 500;
    text-align: left;
    padding: 0.75rem;
}

.stDataFrame [data-testid="stTable"] td {
    padding: 0.75rem;
    border-top: 1px solid #E0E0E0;
}

.stDataFrame [data-testid="stTable"] tr:nth-child(even) {
    background-color: #F5F5F5;
}
endef
export APP_STATIC_CSS

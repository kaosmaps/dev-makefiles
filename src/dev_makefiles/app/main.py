# src/dev_makefiles/app/main.py
import streamlit as st
from pathlib import Path
from dev_makefiles.services import MainService

def load_css():
    css_file = Path(__file__).parent / "static" / "style.css"
    with open(css_file) as f:
        st.markdown(f"<style>{f.read()}</style>", unsafe_allow_html=True)

st.set_page_config(page_title="dev-makefiles Streamlit App", page_icon=":eyeglasses:", layout="wide")
st.markdown("""
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    """, unsafe_allow_html=True)
load_css()

st.title("dev-makefiles Streamlit App")

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

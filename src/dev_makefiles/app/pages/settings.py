# src/dev_makefiles/app/pages/settings.py
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

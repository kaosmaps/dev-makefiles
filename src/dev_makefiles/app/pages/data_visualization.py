# src/dev_makefiles/app/pages/data_visualization.py
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

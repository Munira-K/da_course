
import numpy as np
import pandas as pd
import plotly.express as px
import streamlit as st
import plotly.express as px
from db_connection import get_invoice_data

invoice = get_invoice_data()

st.title(':red[Chinook] :blue-background[ Sales Report] :book:')

with st.sidebar:
    min_total = st.slider('Минимальная сумма счета', min_value=0, max_value=int(invoice['total'].max()), value=10)
    max_total = st.slider('Максимальная сумма счета', min_value=0, max_value=int(invoice['total'].max()), value=int(invoice['total'].max()))
    country = st.multiselect('Выберите страну', options=invoice['billing_country'].unique())

df = invoice[
    (invoice['total'] >= min_total) &
    (invoice['total'] <= max_total) &
    (invoice['billing_country'].isin(country) if country else True)
]

if st.checkbox('Показать/скрыть данные'):
    st.dataframe(df)

fig1 = px.bar(df, x='billing_country', y='total', title='Продажи по странам')
st.plotly_chart(fig1)

fig2 = px.line(df, x='invoice_date', y='total', title='Продажи по датам')
st.plotly_chart(fig2)



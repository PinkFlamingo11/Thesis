import streamlit as st
import openai
import os

# Laden des API-Schlüssels aus der Umgebungsvariable
openai.api_key = os.getenv("OPENAI_API_KEY")

st.title("Chat mit GPT-3.5 Turbo")
st.subheader("Stellen Sie Ihre Fragen an GPT!")

# Eingabefeld für die Benutzereingabe
user_input = st.text_area("Ihre Frage:", placeholder="Geben Sie hier Ihre Frage ein...")

# Senden-Knopf
if st.button("Senden"):
    if user_input.strip() == "":
        st.error("Bitte geben Sie eine Frage ein!")
    else:
        with st.spinner("GPT antwortet..."):
            try:
                # API-Aufruf
                response = openai.ChatCompletion.create(
                    model="gpt-3.5-turbo",
                    messages=[
                        {"role": "system", "content": "You are a helpful assistant."},
                        {"role": "user", "content": user_input}
                    ],
                    max_tokens=250,
                    temperature=0.7
                )
                # GPT-Antwort anzeigen
                answer = response["choices"][0]["message"]["content"].strip()
                st.success("Antwort:")
                st.write(answer)
            except Exception as e:
                st.error(f"Fehler: {str(e)}")

# Seiten aktualisieren
if st.button("Seite aktualisieren"):
    st.experimental_rerun()

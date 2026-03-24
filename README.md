# flutterTeste

Siga os passos abaixo para rodar o projeto localmente no navegador:

---

## 📦 1. Instalar dependências

Execute o comando abaixo na raiz do projeto:

```bash
flutter pub get
```

Esse comando baixa todas as dependências necessárias definidas no projeto.

---

## 🌐 2. Rodar o projeto no navegador

Execute:

```bash
flutter run -d web-server --web-port=8888
```

---

## 🔗 3. Acessar no navegador

Após rodar o comando, abra o navegador e acesse:

```
http://localhost:8888
```

---

## ⚠️ Observações

* Certifique-se de que o Flutter está instalado corretamente
* Verifique se o suporte para Web está habilitado:

```bash
flutter config --enable-web
```

* Caso a porta 8888 esteja ocupada, você pode alterar para outra:

```bash
flutter run -d web-server --web-port=8080
```

---

## ✅ Pronto!

Agora o projeto estará rodando localmente no navegador 🎉

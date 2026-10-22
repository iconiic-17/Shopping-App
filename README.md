<!-- Animated header banner -->
<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:02569B,100:13B9FD&height=200&section=header&text=Shopping%20App&fontSize=60&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc=Flutter%20E-Commerce%20Mobile%20App&descAlignY=58&descSize=20" alt="header" width="100%" />
</div>

<!-- Typing animation -->
<div align="center">
  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=22&duration=3000&pause=1000&color=13B9FD&center=true&vCenter=true&width=650&lines=Cross-platform+Shopping+App+%F0%9F%9B%8D%EF%B8%8F;Built+with+Flutter+%26+Dart;Clean+Architecture+%2B+BLoC;Developed+during+NTI+Training+%F0%9F%8E%93" alt="Typing SVG" />
  </a>
</div>

<br/>

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![BLoC](https://img.shields.io/badge/BLoC-02569B?style=for-the-badge)
![Clean Architecture](https://img.shields.io/badge/Clean_Architecture-4CAF50?style=for-the-badge)
![REST API](https://img.shields.io/badge/REST_API-009688?style=for-the-badge)

</div>

<br/>

## 📖 About The Project

**Shopping App** is an 8-screen cross-platform e-commerce mobile application built with **Flutter** and **Dart** as part of the **National Telecommunication Institute (NTI)** training program.

I served as the **Team Lead**: organizing the team's workflow, helping teammates resolve technical issues, and keeping the codebase stable through Git and GitHub.

<br/>

## ✨ Features

- 🔐 **Authentication**: sign up and log in
- 🏠 **Home**: products listed from a deployed REST API
- 🗂️ **Categories**: browse products by category
- 🔎 **Search**: find products quickly
- 📦 **Product Details**: full product information
- 🛒 **Cart**: add and manage items
- ❤️ **Favorites**: save products you love
- 👤 **Account**: view and edit your user data

<br/>

## 🏗️ Architecture

The app follows **Clean Architecture** with **BLoC** for state management:

- A shared **core** module: app theme, API constants, reusable widgets, and dependency injection
- One folder per **feature**, each split into three layers:
  - **Data**: API calls and models
  - **Domain**: entities and business logic
  - **Presentation**: screens, widgets, and BLoC

# <img src=".github/assets/logo.png" alt="class logo" class="logo" width="120"/> R2.02 - Développement d'applications avec IHM

### IUT d'Aix-Marseille - Département Informatique Aix-en-Provence

* **Ressource :** [Syllabus R2.02](https://github.com/IUTInfoAix-R202/syllabus) (compétences, calendrier, évaluations, ressources détaillées)

* **Équipe pédagogique :**

  * [Sébastien Nedjar](mailto:sebastien.nedjar@univ-amu.fr) - responsable du module
  * [Frédéric Flouvat](mailto:frederic.flouvat@univ-amu.fr)
  * [Sophie Nabitz](mailto:sophie.nabitz@univ-avignon.fr)
  * [Samir Chtioui](mailto:samir.chtioui@gmail.com)

* **Besoin d'aide ?** [Email](mailto:sebastien.nedjar@univ-amu.fr) pour toute question

---

## Bienvenue

Ce module vous apprend à **concevoir et développer des applications avec une interface graphique** (IHM) en Java avec JavaFX. Au fil des 5 TP, vous construirez progressivement les compétences nécessaires pour réaliser la **SAÉ 2.01** : une interface d'extraction et de manipulation de données pour des capteurs de détection de chauves-souris.

Les TP sont distribués via **GitHub Classroom** : chaque acceptation crée automatiquement un dépôt personnel dans l'organisation `IUTInfoAix-R202-2026`. Ouvrez-le dans **GitHub Codespaces** pour travailler directement dans le navigateur.

> [!IMPORTANT]
> Pour chaque TP, vous devez **accepter le devoir** via le lien Classroom ci-dessous. C'est dans votre dépôt personnel que vous travaillez et que votre progression est évaluée automatiquement. Le calendrier détaillé (répartition des TP sur les semaines) est publié dans le [syllabus](https://github.com/IUTInfoAix-R202/syllabus).

---

## Travaux pratiques

| Répartition | TP | Thème | Accès |
|---|---|---|---|
| s1-s2 (6 h) | **TP1 - Bases JavaFX** | Stage, Scene, Node, layouts, événements | [Accepter le TP1](https://classroom.github.com/a/9gAbmj0v) |
| s2-s3 (8 h) | **TP2 - Propriétés et bindings** | IntegerProperty, bind, bindBidirectional, ChangeListener | [Accepter le TP2](https://classroom.github.com/a/o8W7l2oc) |
| s4 (8 h) | **TP3 - FXML** | Interface déclarative, FXMLLoader, contrôleurs, CSS | [Accepter le TP3](https://classroom.github.com/a/m_6Oq_Uc) |
| s6 (8 h) | **TP4 - MVVM** | Architecture Model-View-ViewModel, testabilité | *à venir* |
| s7 (4 h) | **TP5 - Persistance** | JDBC, JPA, DAO, bases de données (slot SAÉ, compte CC1 R2.02) | *à venir* |

> [!WARNING]
> **Erreur "Repository Access Issue" après avoir accepté un devoir ?**
>
> Il arrive que Classroom affiche l'écran *"You no longer have access to your assignment repository. Contact your teacher for support"* au lieu de vous rediriger vers votre dépôt. **Pas de panique** : votre dépôt **a bien été créé**, c'est juste la redirection qui a échoué.
>
> Marche à suivre :
> 1. **Vérifiez votre boîte mail** : au moment de l'acceptation du devoir, GitHub vous envoie une invitation à rejoindre le dépôt. Accepter cette invitation débloque souvent l'accès.
> 2. Si vous n'avez pas reçu cet email, ouvrez directement votre dépôt à l'adresse :
>    ```
>    https://github.com/IUTInfoAix-R202-2026/tpN-VOTRE_LOGIN_GITHUB
>    ```
>    (remplacez `N` par le numéro du TP et `VOTRE_LOGIN_GITHUB` par votre identifiant GitHub)
> 3. Ou parcourez la liste de vos dépôts sur <https://github.com/IUTInfoAix-R202-2026> - vous devriez y voir le vôtre.
> 4. Si rien de tout ça ne débloque la situation, demandez à l'équipe pédagogique de vous attribuer manuellement les droits en écriture sur votre dépôt.

---

## Cours magistraux

Les supports de cours sont disponibles en ligne :

| CM | Thème | Slides |
|---|---|---|
| CM1 | Fondations de l'IHM et première immersion JavaFX | [Voir les slides](https://iutinfoaix-r202.github.io/cours/cm1-fondations-ihm.html) |
| CM2 | Propriétés, bindings et contrôles | [Voir les slides](https://iutinfoaix-r202.github.io/cours/cm2-donnees-et-liaison.html) |
| CM3 | Architecture des IHM et FXML | [Voir les slides](https://iutinfoaix-r202.github.io/cours/cm3-architecture-fxml.html) |
| CM4 | MVVM, persistance et synthèse | [Voir les slides](https://iutinfoaix-r202.github.io/cours/cm4-mvvm-persistance.html) |

---

## Comment travailler

1. **Acceptez le devoir** en cliquant sur le lien Classroom du TP de la semaine
2. **Ouvrez votre dépôt** dans GitHub Codespaces (bouton "Code" -> "Codespaces" -> "Create codespace on main")
3. **Lisez le README** du TP - il contient les objectifs, les explications et les exercices détaillés
4. **Activez les tests** un par un et implémentez le code pour les faire passer (TDD baby steps)
5. **Poussez votre code** régulièrement - votre score est calculé automatiquement à chaque push

> [!TIP]
> **Copilot Chat** est disponible dans votre Codespace comme tuteur. Il est configuré pour vous guider sans donner directement la solution. N'hésitez pas à lui poser des questions quand vous bloquez.

---

## Évaluation

- **CC1** : moyenne des notes autograding des TP (score affiché sur 1000 par Classroom, ramené sur 20 au bulletin en divisant par 50 ; votre score augmente à chaque test qui passe) - coeff. 10
- **CC2** : participation et implication (coeff. 10)
- **CC3** : mini-application JavaFX sur feuille (coeff. 40)

Pour les grilles détaillées (CC2 et CC3), voir le [syllabus](https://github.com/IUTInfoAix-R202/syllabus).

> [!TIP]
> **Pour s'entraîner au CC3** : le dépôt [**`testIHM`**](https://github.com/IUTInfoAix-R202/testIHM) regroupe 10 sujets de tests d'IHM 2013-2022 (Morpion, Othello, Mastermind, Taquin, Lights Out, Tracé de fonction, Wordle…) - tous compilent et tournent sur la même stack Java 25 / JavaFX 25 / Maven Wrapper que vos TPs, avec 116 tests fonctionnels en CI. Idéal pour s'entraîner à composer des applications graphiques complètes en temps limité.

---

## Environnement technique

- **Java 25** + **JavaFX 25**
- **Apache Maven 3.9.14 via Maven Wrapper** (`./mvnw` fourni, aucune installation nécessaire)
- **GitHub Codespaces** (environnement de développement dans le navigateur)
- **TestFX** + JUnit 5 + AssertJ (tests automatiques)

---

<!-- Dernière mise à jour : 2026-05-16T14:13:39+02:00 -->
*IUT d'Aix-Marseille - Département Informatique - 2025-2026*

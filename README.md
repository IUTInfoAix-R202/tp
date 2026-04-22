# <img src="https://raw.githubusercontent.com/IUTInfoAix-R510/Syllabus/main/assets/logo.png" alt="class logo" class="logo"/> R2.02 - Développement d'applications avec IHM

### IUT d'Aix-Marseille - Département Informatique Aix-en-Provence

* **Ressource :** [R2.02](https://cache.media.enseignementsup-recherche.gouv.fr/file/SPE4-MESRI-17-6-2021/35/5/Annexe_17_INFO_BUT_annee_1_1411355.pdf)

* **Responsable :**

  * [Sébastien Nedjar](mailto:sebastien.nedjar@univ-amu.fr)

* **Enseignants :**

  * [Frédéric Flouvat](mailto:frederic.flouvat@univ-amu.fr)
  * [Sophie Nabitz](mailto:sophie.nabitz@univ-avignon.fr)
  * [Samir Chtioui](mailto:samir.chtioui@gmail.com)

* **Besoin d'aide ?**
    * [Email](mailto:sebastien.nedjar@univ-amu.fr) pour toute question

---

## Bienvenue

Ce module vous apprend à **concevoir et développer des applications avec une interface graphique** (IHM) en Java avec JavaFX. Au fil des 5 TP, vous construirez progressivement les compétences nécessaires pour réaliser la **SAE 2.01** : une interface d'extraction et de manipulation de données pour des capteurs de détection de chauve-souris.

Chaque semaine, un nouveau TP est à réaliser. Cliquez sur le lien Classroom correspondant pour créer votre dépôt personnel, puis ouvrez-le dans GitHub Codespaces pour travailler directement dans le navigateur.

> [!IMPORTANT]
> Pour chaque TP, vous devez **accepter le devoir** via le lien Classroom ci-dessous. Cela crée automatiquement un dépôt à votre nom dans l'organisation `IUTInfoAix-R202-2026`. C'est dans ce dépôt que vous travaillez et que votre progression est évaluée automatiquement.

---

## Travaux pratiques

| Semaine | TP | Thème | Lien Classroom |
|---|---|---|---|
| 1 | **TP1 - Bases JavaFX** | Stage, Scene, Node, layouts, événements | [Accepter le TP1](https://classroom.github.com/a/9gAbmj0v) |
| 2 | **TP2 - Propriétés et bindings** | IntegerProperty, bind, bindBidirectional, ChangeListener | [Accepter le TP2](https://classroom.github.com/a/o8W7l2oc) |
| 3 | **TP3 - FXML** | Interface déclarative, FXMLLoader, contrôleurs, CSS | *à venir* |
| 4 | **TP4 - MVVM** | Architecture Model-View-ViewModel, testabilité | *à venir* |
| 5 | **TP5 - Persistance** | JDBC, JPA, DAO, bases de données | *à venir* |

> [!WARNING]
> **Erreur "Repository Access Issue" après avoir accepté un devoir ?**
>
> Il arrive que Classroom affiche l'écran *"You no longer have access to your assignment repository. Contact your teacher for support"* au lieu de vous rediriger vers votre dépôt. **Pas de panique** : votre dépôt **a bien été créé**, c'est juste la redirection qui a échoué.
>
> Pour le retrouver :
> 1. Ouvrez directement votre dépôt à l'adresse :
>    ```
>    https://github.com/IUTInfoAix-R202-2026/tpN-VOTRE_LOGIN_GITHUB
>    ```
>    (remplacez `N` par le numéro du TP et `VOTRE_LOGIN_GITHUB` par votre identifiant GitHub)
> 2. Ou parcourez la liste de vos dépôts sur <https://github.com/IUTInfoAix-R202-2026> — vous devriez y voir le vôtre.
>
> Si vraiment vous ne trouvez pas, contactez votre enseignant·e, il/elle pourra vérifier la création côté admin.

---

## Cours magistraux

Les supports de cours sont disponibles en ligne :

| CM | Thème | Slides |
|---|---|---|
| CM1 | Fondations de l'IHM et première immersion JavaFX | [Voir les slides](https://iutinfoaix-r202.github.io/cours/cm1-fondations-ihm.html) |
| CM2 | Propriétés, bindings et contrôles | [Voir les slides](https://iutinfoaix-r202.github.io/cours/cm2-donnees-et-liaison.html) |
| CM3 | Architecture des IHM et FXML | *à venir* |
| CM4 | MVVM, persistance et synthèse | *à venir* |

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

- **CC1** : note d'évaluation de TP - autograding sur 100 points, votre score augmente à chaque test qui passe (coeff. 10)
- **CC2** : participation et implication (coeff. 10)
- **CC3** : mini-application JavaFX sur feuille (coeff. 40)

---

## Environnement technique

- **Java 25** + **JavaFX 25**
- **Maven** (via le wrapper `./mvnw` - aucune installation nécessaire)
- **GitHub Codespaces** (environnement de développement dans le navigateur)
- **TestFX** + JUnit 5 + AssertJ (tests automatiques)

---

<!-- Dernière mise à jour : 2026-04-22T15:38:43+02:00 -->
*IUT d'Aix-Marseille - Département Informatique - 2025-2026*

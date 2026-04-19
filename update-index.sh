#!/bin/bash
# Génère automatiquement la table des TP dans README.md
# en lisant les liens Classroom depuis chaque repo tpN.
#
# Usage : ./update-index.sh
# Nécessite : gh (GitHub CLI) authentifié

set -euo pipefail

ORG="IUTInfoAix-R202"
COURS_URL="https://iutinfoaix-r202.github.io/cours"

# Configuration des TP : numéro|titre|thème|semaine
TPS=(
  "1|Bases JavaFX|Stage, Scene, Node, layouts, événements|1"
  "2|Propriétés et bindings|IntegerProperty, bind, bindBidirectional, ChangeListener|2"
  "3|FXML|Interface déclarative, FXMLLoader, contrôleurs, CSS|3"
  "4|MVVM|Architecture Model-View-ViewModel, testabilité|4"
  "5|Persistance|JDBC, JPA, DAO, bases de données|5"
)

# Configuration des CM : numéro|titre|slug du fichier
CMS=(
  "1|Fondations de l'IHM et première immersion JavaFX|cm1-fondations-ihm"
  "2|Propriétés, bindings et contrôles|cm2-donnees-et-liaison"
  "3|Architecture des IHM et FXML|cm3-architecture-ihm"
  "4|MVVM, persistance et synthèse|cm4-synthese"
)

# Extraire le lien Classroom d'un repo
get_classroom_link() {
  local repo="$1"
  # Vérifie que le repo existe et n'est pas archivé
  local info
  info=$(gh repo view "$ORG/$repo" --json isArchived,url 2>/dev/null) || return 1
  local is_archived
  is_archived=$(echo "$info" | python3 -c "import sys,json; print(json.load(sys.stdin)['isArchived'])" 2>/dev/null)
  local real_url
  real_url=$(echo "$info" | python3 -c "import sys,json; print(json.load(sys.stdin)['url'])" 2>/dev/null)

  # Vérifier que ce n'est pas une redirection vers l'archive
  if [ "$is_archived" = "True" ] || echo "$real_url" | grep -q "archive"; then
    return 1
  fi

  # Récupérer le README et extraire le lien Classroom
  local readme
  readme=$(gh api "repos/$ORG/$repo/readme" --jq '.content' 2>/dev/null | base64 -d 2>/dev/null) || return 1
  local link
  link=$(echo "$readme" | grep -oP 'https://classroom\.github\.com/a/[a-zA-Z0-9]+' | head -1)

  if [ -n "$link" ]; then
    echo "$link"
  else
    return 1
  fi
}

# Vérifier si un fichier de cours existe sur GitHub Pages
check_cm_exists() {
  local slug="$1"
  curl -sf -o /dev/null "$COURS_URL/$slug.html" 2>/dev/null
}

echo "Génération de l'index des TP..."

# Construire la table des TP
TP_TABLE="| Semaine | TP | Thème | Lien Classroom |
|---|---|---|---|"

for tp_config in "${TPS[@]}"; do
  IFS='|' read -r num titre theme semaine <<< "$tp_config"
  repo="tp$num"
  echo -n "  TP$num ($titre)... "

  link=$(get_classroom_link "$repo" 2>/dev/null || true)
  if [ -n "$link" ]; then
    TP_TABLE="$TP_TABLE
| $semaine | **TP$num - $titre** | $theme | [Accepter le TP$num]($link) |"
    echo "OK ($link)"
  else
    TP_TABLE="$TP_TABLE
| $semaine | **TP$num - $titre** | $theme | *à venir* |"
    echo "pas encore publié"
  fi
done

# Construire la table des CM
CM_TABLE="| CM | Thème | Slides |
|---|---|---|"

for cm_config in "${CMS[@]}"; do
  IFS='|' read -r num titre slug <<< "$cm_config"
  echo -n "  CM$num ($titre)... "

  if check_cm_exists "$slug"; then
    CM_TABLE="$CM_TABLE
| CM$num | $titre | [Voir les slides]($COURS_URL/$slug.html) |"
    echo "OK"
  else
    CM_TABLE="$CM_TABLE
| CM$num | $titre | *à venir* |"
    echo "pas encore publié"
  fi
done

# Générer le README complet
cat > README.md << HEREDOC
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
> Pour chaque TP, vous devez **accepter le devoir** via le lien Classroom ci-dessous. Cela crée automatiquement un dépôt à votre nom dans l'organisation \`IUTInfoAix-R202-2026\`. C'est dans ce dépôt que vous travaillez et que votre progression est évaluée automatiquement.

---

## Travaux pratiques

$TP_TABLE

---

## Cours magistraux

Les supports de cours sont disponibles en ligne :

$CM_TABLE

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

- **TP (autograding)** : chaque TP est noté automatiquement sur 100 points. Votre score augmente à chaque test qui passe.
- **CC2** : évaluation dirigée + QCM
- **CC3** : mini-application en 4h (tout ce qui a été vu en TP)

---

## Environnement technique

- **Java 25** + **JavaFX 25**
- **Maven** (via le wrapper \`./mvnw\` - aucune installation nécessaire)
- **GitHub Codespaces** (environnement de développement dans le navigateur)
- **TestFX** + JUnit 5 + AssertJ (tests automatiques)

---

<!-- Dernière mise à jour : $(date -Iseconds) -->
*IUT d'Aix-Marseille - Département Informatique - 2025-2026*
HEREDOC

echo ""
echo "README.md mis à jour."

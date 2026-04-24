#!/bin/bash
# Génère automatiquement la table des TP et des CM dans README.md
# en s'appuyant sur la config TPS / CMS ci-dessous.
#
# Usage : ./update-index.sh
# Nécessite : gh (GitHub CLI) authentifié, python3, curl, base64
#
# Convention :
# - TPS config : numéro|titre|thème|répartition|status
#   * status = published (lien Classroom exposé aux étudiants)
#   * status = draft      (affiché "à venir" même si un lien Classroom
#                          existe dans le repo - utile pendant la
#                          rédaction d'un TP)
# - CMS config : numéro|titre|slug du fichier
#   * Le script détecte automatiquement si le CM est publié sur
#     GitHub Pages (fichier HTML accessible) et affiche le lien ou
#     "à venir" selon.

set -euo pipefail

ORG="IUTInfoAix-R202"
COURS_URL="https://iutinfoaix-r202.github.io/cours"

# Configuration des TP
TPS=(
  "1|Bases JavaFX|Stage, Scene, Node, layouts, événements|s1-s2 (6 h)|published"
  "2|Propriétés et bindings|IntegerProperty, bind, bindBidirectional, ChangeListener|s2-s3 (8 h)|published"
  "3|FXML|Interface déclarative, FXMLLoader, contrôleurs, CSS|s4 (8 h)|draft"
  "4|MVVM|Architecture Model-View-ViewModel, testabilité|s6 (8 h)|draft"
  "5|Persistance|JDBC, JPA, DAO, bases de données (slot SAÉ, compte CC1 R2.02)|s7 (4 h)|draft"
)

# Configuration des CM
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
TP_TABLE="| Répartition | TP | Thème | Accès |
|---|---|---|---|"

for tp_config in "${TPS[@]}"; do
  IFS='|' read -r num titre theme repartition status <<< "$tp_config"
  repo="tp$num"
  echo -n "  TP$num ($titre) [$status]... "

  if [ "$status" = "published" ]; then
    link=$(get_classroom_link "$repo" 2>/dev/null || true)
    if [ -n "$link" ]; then
      TP_TABLE="$TP_TABLE
| $repartition | **TP$num - $titre** | $theme | [Accepter le TP$num]($link) |"
      echo "OK ($link)"
    else
      # Status=published mais aucun lien Classroom détecté : bug de config ou repo vide
      TP_TABLE="$TP_TABLE
| $repartition | **TP$num - $titre** | $theme | *lien manquant* |"
      echo "ERREUR : status=published mais aucun lien Classroom trouvé"
    fi
  else
    TP_TABLE="$TP_TABLE
| $repartition | **TP$num - $titre** | $theme | *à venir* |"
    echo "draft (lien non exposé)"
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

Les TP sont distribués via **GitHub Classroom** : chaque acceptation crée automatiquement un dépôt personnel dans l'organisation \`IUTInfoAix-R202-2026\`. Ouvrez-le dans **GitHub Codespaces** pour travailler directement dans le navigateur.

> [!IMPORTANT]
> Pour chaque TP, vous devez **accepter le devoir** via le lien Classroom ci-dessous. C'est dans votre dépôt personnel que vous travaillez et que votre progression est évaluée automatiquement. Le calendrier détaillé (répartition des TP sur les semaines) est publié dans le [syllabus](https://github.com/IUTInfoAix-R202/syllabus).

---

## Travaux pratiques

$TP_TABLE

> [!WARNING]
> **Erreur "Repository Access Issue" après avoir accepté un devoir ?**
>
> Il arrive que Classroom affiche l'écran *"You no longer have access to your assignment repository. Contact your teacher for support"* au lieu de vous rediriger vers votre dépôt. **Pas de panique** : votre dépôt **a bien été créé**, c'est juste la redirection qui a échoué.
>
> Marche à suivre :
> 1. **Vérifiez votre boîte mail** : au moment de l'acceptation du devoir, GitHub vous envoie une invitation à rejoindre le dépôt. Accepter cette invitation débloque souvent l'accès.
> 2. Si vous n'avez pas reçu cet email, ouvrez directement votre dépôt à l'adresse :
>    \`\`\`
>    https://github.com/IUTInfoAix-R202-2026/tpN-VOTRE_LOGIN_GITHUB
>    \`\`\`
>    (remplacez \`N\` par le numéro du TP et \`VOTRE_LOGIN_GITHUB\` par votre identifiant GitHub)
> 3. Ou parcourez la liste de vos dépôts sur <https://github.com/IUTInfoAix-R202-2026> - vous devriez y voir le vôtre.
> 4. Si rien de tout ça ne débloque la situation, demandez à l'équipe pédagogique de vous attribuer manuellement les droits en écriture sur votre dépôt.

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

- **CC1** : moyenne des notes autograding des TP (score affiché sur 1000 par Classroom, ramené sur 20 au bulletin en divisant par 50 ; votre score augmente à chaque test qui passe) - coeff. 10
- **CC2** : participation et implication (coeff. 10)
- **CC3** : mini-application JavaFX sur feuille (coeff. 40)

Pour les grilles détaillées (CC2 et CC3), voir le [syllabus](https://github.com/IUTInfoAix-R202/syllabus).

---

## Environnement technique

- **Java 25** + **JavaFX 25**
- **Apache Maven 3.9.14 via Maven Wrapper** (\`./mvnw\` fourni, aucune installation nécessaire)
- **GitHub Codespaces** (environnement de développement dans le navigateur)
- **TestFX** + JUnit 5 + AssertJ (tests automatiques)

---

<!-- Dernière mise à jour : $(date -Iseconds) -->
*IUT d'Aix-Marseille - Département Informatique - 2025-2026*
HEREDOC

echo ""
echo "README.md mis à jour."

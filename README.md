# ich-0324-xls-coordinates

[![CICD](https://github.com/cp-23fam/ich-0324-xls-coordinates/actions/workflows/release.yml/badge.svg)](https://github.com/cp-23fam/ich-0324-xls-coordinates/actions/workflows/release.yml)

## Introduction

Dans le cadre de cet exercice, vous allez développer une **commandlet PowerShell 7** permettant de convertir une coordonnée Excel (par exemple `A1`) en coordonnée numérique utilisable pour une matrice (par exemple `[1, 1]`). Cette fonctionnalité est essentielle pour automatiser l’écriture dans des fichiers Excel via PowerShell, où certaines librairies attendent des indices numériques plutôt que des références de cellules au format Excel.

**Exemples :**

| Coordonnée Excel | Coordonnée Numérique |
| ---------------- | -------------------- |
| A1               | [1, 1]               |
| D3               | [4, 3]               |
| Z10              | [26, 10]             |

L'utilisateur de votre commandlet l'installera à l'aide de la commande _Install-Module_, et pourra l'utiliser pour pour déterminer dans quelle cellule écrire lorsqu'il manipulera un fichier Excel via PowerShell.
Le nom du module PowerShell a créer est _XlsCoordinatesConverter-xxx_, où xxx représente les trois lettres de votre nom d'utilisateur Ceff en minuscule (cp-20abc)

---

## Objectifs de l’exercice

L’objectif de cet exercice est de vous faire pratiquer l’ensemble du cycle DevOps dans le cadre d’un développement PowerShell :

1. **Définir les récits utilisateurs**

   - Comment utiliser la commandlet.
   - Quels sont les paramètres attendus.
   - Comportement de la fonction avec des données erronées.
   - Résultat attendu.

2. **Créer l’environnement de développement**

   - Utilisation d’un `devcontainer` pour uniformiser l’environnement de travail.
   - Développement à l'aide de PowerShell 7

3. **Créer la commandlet PowerShell**

   - Nommer la commandlet _ConvertFrom-XlsCoordinates_.
   - La coordonnée à convertir (par exemple : D3) est fournie au travers du paramètres _-Cell_.
   - La commandlet retourne une _HashTable_ contenant une clé _Column_ et _Row_.
   - Découper les opérations dans des sous-fonctions pour faciliter les tests unitaires.
   - Le code doit être **valide pour `PSScriptAnalyzer`** (aucune erreur ou warning).
   - S’assurer que le **formatage du code est standardisé** (utilisation de l’extension VSCode Prettier).
   - La commandlet doit pouvoir convertir toute coordonnée Excel valide en indices numériques.
   - La commandlet doit être fonctionnelle sur les plateformes _Windows_ et _Linux (Ubuntu)_.

4. **Créer les tests unitaires**

   - Utilisation de **Pester**.
   - Couverture de code à 100%.

5. **Créer le module PowerShell**

   - Organiser le code sous forme de module réutilisable.
   - Préparer la publication sur la PowerShell Gallery.

6. **Automatiser les actions DevOps**

   - Utilisation de la librairie InvokeBuild.
   - Analyse de la qualité du code avec `PSScriptAnalyzer`.
   - Exécution des tests et mesure de code coverage.
   - Build et publication automatisés via `Invoke-Build`.

7. **Créer un workflow GitHub Actions**

   - **À chaque commit sur une branche `feature`** : lancer les tâches `Pester` et `PSScriptAnalyzer`.
   - **À chaque merge sur `develop`** : lancer les tâches `Pester`, `PSScriptAnalyzer` et build du module.
   - **À chaque merge sur `main`** : lancer les tâches `Pester`, `PSScriptAnalyzer`, build du module et publication sur PowerShell Gallery.

8. **Implémenter le workflow sur Gitea (self-hosted)**
   - Configurer un runner Gitea pour exécuter les workflows.
   - Reproduire le même comportement que le workflow GitHub Actions :
     - Tests Pester et PSScriptAnalyzer sur les branches `feature`.
     - Tests, analyse et build sur `develop`.
     - Tests, analyse, build et publication sur `main`.

---

## Consignes pédagogiques

1. **Utiliser le GitHub Flow**

   - Branches : `main`, `develop`, `feature/*`, `hotfix/*`.
   - Chaque fonctionnalité doit être développée sur une branche `feature`.
   - Les corrections critiques doivent passer par des branches `hotfix`.

2. **Fork du dépôt**

   - Chaque étudiant doit forker ce dépôt pour travailler sur sa propre version.

3. **Organisation du projet**

   - Suivre les bonnes pratiques PowerShell pour l’organisation du module et des tests.
   - Découper le code en fonctions testables et documentées.
   - Maintenir le code **formaté et validé par `PSScriptAnalyzer`**.

4. **Livrables**

   - Le module complet avec la commandlet fonctionnelle.
   - Les tests Pester couvrant toutes les branches du code.
   - Les workflows GitHub Actions et Gitea configurés.
   - Le fichier `README.md` mis à jour avec la documentation de la commandlet.

5. **Pull Request**
   - Une fois le travail terminé, chaque étudiant soumettra une **Pull Request** pour évaluation.

---

## Ressources utiles

- [Pester – Testing Framework pour PowerShell](https://pester.dev/)
- [PSScriptAnalyzer – Analyse statique de code PowerShell](https://github.com/PowerShell/PSScriptAnalyzer)
- [PowerShell Gallery – Publication de modules](https://www.powershellgallery.com/)
- [Invoke-Build – Automatisation des builds PowerShell](https://github.com/nightroman/Invoke-Build)
- [GitHub Actions - Automate your workflow from idea to production] (https://github.com/features/actions)
- [Gitea – Documentation des actions et runners](https://docs.gitea.io/en-us/actions/)

---

## Exemple d’utilisation de la commandlet

```powershell
# Convertir une cellule Excel en indices numériques
ConvertFrom-XlsCoordinates -Cell 'D3'
# Résultat attendu : @{ 'Column' = 4; 'Row' = 3 }
```

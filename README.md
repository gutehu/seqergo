# SeqErgo

Application Android Flutter de séquençage d’activités opérateur.

## Lancer

```bash
flutter run
```

Premier écran : choix du type d’observation (manuel, zones d’atteinte, reconnaissance d’activité).

Cochez un ou plusieurs modes, puis configurez le protocole :

- **Manuel** : classes / sous-classes (comptage ou chronomètre)
- **Reconnaissance d’activité** : maintenez le bouton pour enregistrer les images caméra, puis relevez l’activité à l’observation
- **Zones d’atteinte** : prévu dans la session, moteur à brancher

Une session mixte alimente un seul actographe. Les données sont en SQLite locale.

## Dépôts liés (Wolopi · SeqOIA)

Les moteurs d’analyse vivent à côté de SeqErgo :

- [wolopi-prep](https://github.com/gutehu/wolopi-prep) — screening SEQOIA Flutter (mobilité / pose)
- [seqoia](https://github.com/gutehu/seqoia) — screening SeqOIA d’origine

En local, ouvrir `seqergo.code-workspace` pour travailler les trois projets dans le même workspace Cursor.

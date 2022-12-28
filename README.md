# Scribe

Scribe is a dictionary application for mobile that also tracks your history.

## Description

Scribe makes it easy to quickly lookup word definitions with examples and synonyms. You can also see what words you have searched in the past.
For this project, I used the free package of 'Oxford Dictionaries API' to get the JSON data. I then serialized it into five heirarchical classes, namely, Word, LexicalEntry, Entry, Sense and Subsense. Each Word contains a list of LexicalEntry. Each LexicalEntry contains a list of Entry and so on.

## Architecture

This application is built on the BLoC pattern.

### Layers

1. Presentation
    * Widgets
2. Business Logic Component
    * Main bloc
    * States
    * Events
3. Domain
    * models
4. Repository
    * Local repository
    * Oxford API

## Authors

ex. Ehab Sohail
ex. Ehab T-48(ehabs1775@gmail.com)

## Acknowledgments

* [@ResoCoder](https://www.youtube.com/@ResoCoder)
* [awesome-readme](https://github.com/matiassingers/awesome-readme)
* [Oxford Dictionaries API](https://developer.oxforddictionaries.com/)

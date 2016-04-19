Examplar
===================
[![Analytics](https://ga-beacon.appspot.com/UA-75651559-2/examplar/readme?pixel)](https://github.com/igrigorik/ga-beacon)

[Dev](https://examplardev.herokuapp.com/) | [Master](https://examplar.herokuapp.com/)


The Exam Search Tool

Development
--------------------
A Web app for searching indexes of exam papers

> **Languages:**
- JS
- HTML
- CSS

---------

>**Technologies:**
- **P**ostgres
- **E**xpress
- **N**odeJS
- **V**ue

Might migrate to KoaJS

----------

Documentation
-------------
Database Consists of:

    ExamBoard
        ExamBoardId*
        ExamBoardName
--------
    Level
        LevelId*
        LevelTitle
--------
    Subject
        SubjectId*
        SubjectTitle
--------
    Topic
        TopicId*
        TopicTitle
--------
    Specification
        SpecificationCode*
        ExamBoardId^
        SubjectId^
        LevelId^
        SpecificationTitle
--------
    ExamPaper
        ExamPaperId*
        ExamBoardId^
        LevelId^
        SubjectId^
        ExamPaperSeason
        ExamPaperDate
--------
    QuestionImage
        QuestionImageId*
        QuestionImateData
--------
    Examiner
        ExaminerId*
        ExaminerText
--------
    Question
        QuestionId*
        ExamPaperId^
        ExaminerId^
        QuestionImageId^
        QuestionNumber
        QuestionText
        QuestionMarks
        QuestionMarkText
--------
    QuestionTopic (Link Table)
        QuestionId*
        TopicId*
--------
    ExamPaperQuestion (Link Table)
        ExamPaperId*
        QuestionId*

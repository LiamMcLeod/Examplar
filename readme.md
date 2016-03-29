Examplar
===================
[![Analytics](https://ga-beacon.appspot.com/UA-75651559-2/examplar/readme?pixel)](https://github.com/igrigorik/ga-beacon)

[Dev](https://examplardev.herokuapp.com/) | [Master](https://examplar.herokuapp.com/)


The Exam Search Tool

Development
--------------------
A Web app for searching exam papers, questions and content.

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

----------

Documentation
-------------

API Routes

Examplar API documentation version 0.0.1
========================================

examplar.herokuapp.com/api

### /search

Queries the Question table for questions like the term entered.

#### /search/{term}{prettify}

The search term used in the SQL query to get questions like {term}


#### get /search/{term}{prettify}
### URI Parameters

-   **pretty**: *(boolean)*

    prettifies JSON output.

    **Example**:

        true

-   **term**: *required (string)*

HTTP status code [200](http://httpstatus.es/200)
------------------------------------------------

### Body

**Type: application/json**

**Example**:

    {
      "QuestionId": 7,
      "QuestionNumber": 7,
      "QuestionText": "Describe a method that can, without the use of binary addition, multiply any unsigned\r\nbinary integer by the binary number 10 (the denary number 2).",
      "ExamPaperUnit": "COMP1",
      "ExamPaperSeason": "Summer",
      "ExamPaperDate": "2014-06-02T00:00:00.000Z",
      "ExamBoardName": "AQA",
      "LevelTitle": "AS",
      "SubjectTitle": "Computing"
    }

### /result

Fetches result based upon an ID parsed.

### /image

### /more

### /related

### /examiner

### /filter



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

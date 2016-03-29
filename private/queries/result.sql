﻿SELECT "QuestionId", "QuestionNumber", "QuestionText", "QuestionMarks", "QuestionMarkText", "ExamPaperUnit", "ExamPaperSeason", "ExamPaperDate", "ExamBoardName", "LevelTitle", "SubjectTitle", "ExaminerNote", "QuestionImageData"
FROM "Question" 
INNER JOIN "ExamPaper" 
ON "Question"."ExamPaperId" = "ExamPaper"."ExamPaperId" 
INNER JOIN "ExamBoard" 
ON "ExamPaper"."ExamBoardId" = "ExamBoard"."ExamBoardId" 
INNER JOIN "Level" 
ON "ExamPaper"."LevelId" = "Level"."LevelId" 
INNER JOIN "Subject" 
ON "ExamPaper"."SubjectId" = "Subject"."SubjectId" 
INNER JOIN "Examiner"
ON "Question"."ExaminerId"="Examiner"."ExaminerId"
INNER JOIN "QuestionImage"
ON "Question"."QuestionImageId"= "QuestionImage"."QuestionImageId"
WHERE "QuestionText" ~* 'figure'
ORDER BY "QuestionNumber"
		
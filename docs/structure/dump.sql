--
-- zazhxtzadxftgyQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: examDB; Type: COMMENT; Schema: -; Owner: root
--
--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ExamBoard; Type: TABLE; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE TABLE "ExamBoard" (
    "ExamBoardName" character varying(20),
    "ExamBoardId" integer NOT NULL
);


ALTER TABLE "ExamBoard" OWNER TO zazhxtzadxftgy;

--
-- Name: ExamBoard_ExamBoardId_seq; Type: SEQUENCE; Schema: public; Owner: zazhxtzadxftgy
--

CREATE SEQUENCE "ExamBoard_ExamBoardId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "ExamBoard_ExamBoardId_seq" OWNER TO zazhxtzadxftgy;

--
-- Name: ExamBoard_ExamBoardId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zazhxtzadxftgy
--

ALTER SEQUENCE "ExamBoard_ExamBoardId_seq" OWNED BY "ExamBoard"."ExamBoardId";


--
-- Name: ExamPaper; Type: TABLE; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE TABLE "ExamPaper" (
    "ExamBoardId" integer,
    "LevelId" integer,
    "SubjectId" integer,
    "ExamPaperSeason" character varying(6),
    "ExamPaperDate" date,
    "ExamPaperUnit" character varying(20),
    "ExamPaperId" integer NOT NULL
);


ALTER TABLE "ExamPaper" OWNER TO zazhxtzadxftgy;

--
-- Name: ExamPaper_ExamPaperId_seq; Type: SEQUENCE; Schema: public; Owner: zazhxtzadxftgy
--

CREATE SEQUENCE "ExamPaper_ExamPaperId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "ExamPaper_ExamPaperId_seq" OWNER TO zazhxtzadxftgy;

--
-- Name: ExamPaper_ExamPaperId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zazhxtzadxftgy
--

ALTER SEQUENCE "ExamPaper_ExamPaperId_seq" OWNED BY "ExamPaper"."ExamPaperId";


--
-- Name: Examiner; Type: TABLE; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE TABLE "Examiner" (
    "ExamPaperId" integer,
    "ExaminerNote" text,
    "QuestionNo" integer,
    "ExaminerId" integer NOT NULL
);


ALTER TABLE "Examiner" OWNER TO zazhxtzadxftgy;

--
-- Name: Level; Type: TABLE; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE TABLE "Level" (
    "LevelTitle" character varying(20),
    "LevelId" integer NOT NULL
);


ALTER TABLE "Level" OWNER TO zazhxtzadxftgy;

--
-- Name: Level_LevelId_seq; Type: SEQUENCE; Schema: public; Owner: zazhxtzadxftgy
--

CREATE SEQUENCE "Level_LevelId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Level_LevelId_seq" OWNER TO zazhxtzadxftgy;

--
-- Name: Level_LevelId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zazhxtzadxftgy
--

ALTER SEQUENCE "Level_LevelId_seq" OWNED BY "Level"."LevelId";


--
-- Name: Question; Type: TABLE; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE TABLE "Question" (
    "ExamPaperId" integer,
    "QuestionNumber" integer,
    "QuestionText" text,
    "QuestionMarkText" text,
    "QuestionMarks" smallint,
    "QuestionImageId" integer,
    "QuestionId" integer NOT NULL,
    "ExaminerId" integer
);


ALTER TABLE "Question" OWNER TO zazhxtzadxftgy;

--
-- Name: QuestionExamPaper; Type: TABLE; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE TABLE "QuestionExamPaper" (
    "QuestiionId" integer,
    "ExamPaperId" integer
);


ALTER TABLE "QuestionExamPaper" OWNER TO zazhxtzadxftgy;

--
-- Name: QuestionExaminer_ExaminerId_seq; Type: SEQUENCE; Schema: public; Owner: zazhxtzadxftgy
--

CREATE SEQUENCE "QuestionExaminer_ExaminerId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "QuestionExaminer_ExaminerId_seq" OWNER TO zazhxtzadxftgy;

--
-- Name: QuestionExaminer_ExaminerId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zazhxtzadxftgy
--

ALTER SEQUENCE "QuestionExaminer_ExaminerId_seq" OWNED BY "Examiner"."ExaminerId";


--
-- Name: QuestionImage; Type: TABLE; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE TABLE "QuestionImage" (
    "QuestionImageId" integer NOT NULL,
    "QuestionImageData" bytea
);


ALTER TABLE "QuestionImage" OWNER TO zazhxtzadxftgy;

--
-- Name: QuestionImage_QuestionImage_Id_seq; Type: SEQUENCE; Schema: public; Owner: zazhxtzadxftgy
--

CREATE SEQUENCE "QuestionImage_QuestionImage_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "QuestionImage_QuestionImage_Id_seq" OWNER TO zazhxtzadxftgy;

--
-- Name: QuestionImage_QuestionImage_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zazhxtzadxftgy
--

ALTER SEQUENCE "QuestionImage_QuestionImage_Id_seq" OWNED BY "QuestionImage"."QuestionImageId";


--
-- Name: QuestionTopic; Type: TABLE; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE TABLE "QuestionTopic" (
    "TopicId" integer,
    "QuestionId" integer
);


ALTER TABLE "QuestionTopic" OWNER TO zazhxtzadxftgy;

--
-- Name: Question_QuestionId_seq; Type: SEQUENCE; Schema: public; Owner: zazhxtzadxftgy
--

CREATE SEQUENCE "Question_QuestionId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Question_QuestionId_seq" OWNER TO zazhxtzadxftgy;

--
-- Name: Question_QuestionId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zazhxtzadxftgy
--

ALTER SEQUENCE "Question_QuestionId_seq" OWNED BY "Question"."QuestionId";


--
-- Name: Specification; Type: TABLE; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE TABLE "Specification" (
    "ExamBoardId" integer NOT NULL,
    "LevelId" integer NOT NULL,
    "SubjectId" integer NOT NULL,
    "SpecificationCode" character varying(10) NOT NULL,
    "SoecificationTitle" character varying(50)
);


ALTER TABLE "Specification" OWNER TO zazhxtzadxftgy;

--
-- Name: Specification_ExamBoardId_seq; Type: SEQUENCE; Schema: public; Owner: zazhxtzadxftgy
--

CREATE SEQUENCE "Specification_ExamBoardId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Specification_ExamBoardId_seq" OWNER TO zazhxtzadxftgy;

--
-- Name: Specification_ExamBoardId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zazhxtzadxftgy
--

ALTER SEQUENCE "Specification_ExamBoardId_seq" OWNED BY "Specification"."ExamBoardId";


--
-- Name: Specification_LevelId_seq; Type: SEQUENCE; Schema: public; Owner: zazhxtzadxftgy
--

CREATE SEQUENCE "Specification_LevelId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Specification_LevelId_seq" OWNER TO zazhxtzadxftgy;

--
-- Name: Specification_LevelId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zazhxtzadxftgy
--

ALTER SEQUENCE "Specification_LevelId_seq" OWNED BY "Specification"."LevelId";


--
-- Name: Specification_SubjectId_seq; Type: SEQUENCE; Schema: public; Owner: zazhxtzadxftgy
--

CREATE SEQUENCE "Specification_SubjectId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Specification_SubjectId_seq" OWNER TO zazhxtzadxftgy;

--
-- Name: Specification_SubjectId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zazhxtzadxftgy
--

ALTER SEQUENCE "Specification_SubjectId_seq" OWNED BY "Specification"."SubjectId";


--
-- Name: Subject; Type: TABLE; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE TABLE "Subject" (
    "SubjectTitle" character varying NOT NULL,
    "SubjectId" integer NOT NULL
);


ALTER TABLE "Subject" OWNER TO zazhxtzadxftgy;

--
-- Name: Subject_SubjectId_seq; Type: SEQUENCE; Schema: public; Owner: zazhxtzadxftgy
--

CREATE SEQUENCE "Subject_SubjectId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Subject_SubjectId_seq" OWNER TO zazhxtzadxftgy;

--
-- Name: Subject_SubjectId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zazhxtzadxftgy
--

ALTER SEQUENCE "Subject_SubjectId_seq" OWNED BY "Subject"."SubjectId";


--
-- Name: Topic; Type: TABLE; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE TABLE "Topic" (
    "TopicTitle" character varying(100),
    "TopicText" text,
    "TopicId" integer NOT NULL,
    "SpecificationCode" character varying
);


ALTER TABLE "Topic" OWNER TO zazhxtzadxftgy;

--
-- Name: Topic_TopicId_seq; Type: SEQUENCE; Schema: public; Owner: zazhxtzadxftgy
--

CREATE SEQUENCE "Topic_TopicId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Topic_TopicId_seq" OWNER TO zazhxtzadxftgy;

--
-- Name: Topic_TopicId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zazhxtzadxftgy
--

ALTER SEQUENCE "Topic_TopicId_seq" OWNED BY "Topic"."TopicId";


--
-- Name: ExamBoardId; Type: DEFAULT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "ExamBoard" ALTER COLUMN "ExamBoardId" SET DEFAULT nextval('"ExamBoard_ExamBoardId_seq"'::regclass);


--
-- Name: ExamPaperId; Type: DEFAULT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "ExamPaper" ALTER COLUMN "ExamPaperId" SET DEFAULT nextval('"ExamPaper_ExamPaperId_seq"'::regclass);


--
-- Name: ExaminerId; Type: DEFAULT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Examiner" ALTER COLUMN "ExaminerId" SET DEFAULT nextval('"QuestionExaminer_ExaminerId_seq"'::regclass);


--
-- Name: LevelId; Type: DEFAULT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Level" ALTER COLUMN "LevelId" SET DEFAULT nextval('"Level_LevelId_seq"'::regclass);


--
-- Name: QuestionId; Type: DEFAULT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Question" ALTER COLUMN "QuestionId" SET DEFAULT nextval('"Question_QuestionId_seq"'::regclass);


--
-- Name: QuestionImageId; Type: DEFAULT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "QuestionImage" ALTER COLUMN "QuestionImageId" SET DEFAULT nextval('"QuestionImage_QuestionImage_Id_seq"'::regclass);


--
-- Name: ExamBoardId; Type: DEFAULT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Specification" ALTER COLUMN "ExamBoardId" SET DEFAULT nextval('"Specification_ExamBoardId_seq"'::regclass);


--
-- Name: LevelId; Type: DEFAULT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Specification" ALTER COLUMN "LevelId" SET DEFAULT nextval('"Specification_LevelId_seq"'::regclass);


--
-- Name: SubjectId; Type: DEFAULT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Specification" ALTER COLUMN "SubjectId" SET DEFAULT nextval('"Specification_SubjectId_seq"'::regclass);


--
-- Name: SubjectId; Type: DEFAULT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Subject" ALTER COLUMN "SubjectId" SET DEFAULT nextval('"Subject_SubjectId_seq"'::regclass);


--
-- Name: TopicId; Type: DEFAULT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Topic" ALTER COLUMN "TopicId" SET DEFAULT nextval('"Topic_TopicId_seq"'::regclass);


--
-- Name: PK_ExamBoard; Type: CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

ALTER TABLE ONLY "ExamBoard"
    ADD CONSTRAINT "PK_ExamBoard" PRIMARY KEY ("ExamBoardId");


--
-- Name: PK_ExamPaper; Type: CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

ALTER TABLE ONLY "ExamPaper"
    ADD CONSTRAINT "PK_ExamPaper" PRIMARY KEY ("ExamPaperId");


--
-- Name: PK_Examiner; Type: CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

ALTER TABLE ONLY "Examiner"
    ADD CONSTRAINT "PK_Examiner" PRIMARY KEY ("ExaminerId");


--
-- Name: PK_Level; Type: CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

ALTER TABLE ONLY "Level"
    ADD CONSTRAINT "PK_Level" PRIMARY KEY ("LevelId");


--
-- Name: PK_Question; Type: CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

ALTER TABLE ONLY "Question"
    ADD CONSTRAINT "PK_Question" PRIMARY KEY ("QuestionId");


--
-- Name: PK_QuestionImage; Type: CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

ALTER TABLE ONLY "QuestionImage"
    ADD CONSTRAINT "PK_QuestionImage" PRIMARY KEY ("QuestionImageId");


--
-- Name: PK_Specification; Type: CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

ALTER TABLE ONLY "Specification"
    ADD CONSTRAINT "PK_Specification" PRIMARY KEY ("SpecificationCode");


--
-- Name: PK_Subject; Type: CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

ALTER TABLE ONLY "Subject"
    ADD CONSTRAINT "PK_Subject" PRIMARY KEY ("SubjectId");


--
-- Name: PK_Topic; Type: CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

ALTER TABLE ONLY "Topic"
    ADD CONSTRAINT "PK_Topic" PRIMARY KEY ("TopicId");


--
-- Name: FKI_ExamBoard_ExamPaper; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_ExamBoard_ExamPaper" ON "ExamPaper" USING btree ("ExamBoardId");


--
-- Name: FKI_ExamBoard_Specification; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_ExamBoard_Specification" ON "Specification" USING btree ("ExamBoardId");


--
-- Name: FKI_ExamPaper_EPQ; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_ExamPaper_EPQ" ON "QuestionExamPaper" USING btree ("ExamPaperId");


--
-- Name: FKI_ExamPaper_Question; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_ExamPaper_Question" ON "Question" USING btree ("ExamPaperId");


--
-- Name: FKI_Examiner_Question; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_Examiner_Question" ON "Question" USING btree ("ExaminerId");


--
-- Name: FKI_Level_ExamPaper; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_Level_ExamPaper" ON "ExamPaper" USING btree ("LevelId");


--
-- Name: FKI_Level_Specification; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_Level_Specification" ON "Specification" USING btree ("LevelId");


--
-- Name: FKI_QuestionImage_Question; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_QuestionImage_Question" ON "Question" USING btree ("QuestionImageId");


--
-- Name: FKI_Question_EPQ; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_Question_EPQ" ON "QuestionExamPaper" USING btree ("QuestiionId");


--
-- Name: FKI_Question_QT; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_Question_QT" ON "QuestionTopic" USING btree ("QuestionId");


--
-- Name: FKI_Specification_Topic; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_Specification_Topic" ON "Topic" USING btree ("SpecificationCode");


--
-- Name: FKI_Subject_ExamPaper; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_Subject_ExamPaper" ON "ExamPaper" USING btree ("SubjectId");


--
-- Name: FKI_Subject_Specification; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_Subject_Specification" ON "Specification" USING btree ("SubjectId");


--
-- Name: FKI_Topic_QT; Type: INDEX; Schema: public; Owner: zazhxtzadxftgy; Tablespace: 
--

CREATE INDEX "FKI_Topic_QT" ON "QuestionTopic" USING btree ("TopicId");


--
-- Name: FK_ExamBoard_ExamPaper; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "ExamPaper"
    ADD CONSTRAINT "FK_ExamBoard_ExamPaper" FOREIGN KEY ("ExamBoardId") REFERENCES "ExamBoard"("ExamBoardId");


--
-- Name: FK_ExamBoard_Specification; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Specification"
    ADD CONSTRAINT "FK_ExamBoard_Specification" FOREIGN KEY ("ExamBoardId") REFERENCES "ExamBoard"("ExamBoardId");


--
-- Name: FK_ExamPaper_EPQ; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "QuestionExamPaper"
    ADD CONSTRAINT "FK_ExamPaper_EPQ" FOREIGN KEY ("ExamPaperId") REFERENCES "ExamPaper"("ExamPaperId");


--
-- Name: FK_ExamPaper_Question; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Question"
    ADD CONSTRAINT "FK_ExamPaper_Question" FOREIGN KEY ("ExamPaperId") REFERENCES "ExamPaper"("ExamPaperId");


--
-- Name: FK_Examiner_Question; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Question"
    ADD CONSTRAINT "FK_Examiner_Question" FOREIGN KEY ("ExaminerId") REFERENCES "Examiner"("ExaminerId");


--
-- Name: FK_Level_ExamPaper; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "ExamPaper"
    ADD CONSTRAINT "FK_Level_ExamPaper" FOREIGN KEY ("LevelId") REFERENCES "Level"("LevelId");


--
-- Name: FK_Level_Specification; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Specification"
    ADD CONSTRAINT "FK_Level_Specification" FOREIGN KEY ("LevelId") REFERENCES "Level"("LevelId");


--
-- Name: FK_QuestionImage_Question; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Question"
    ADD CONSTRAINT "FK_QuestionImage_Question" FOREIGN KEY ("QuestionImageId") REFERENCES "QuestionImage"("QuestionImageId");


--
-- Name: FK_Question_EPQ; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "QuestionExamPaper"
    ADD CONSTRAINT "FK_Question_EPQ" FOREIGN KEY ("QuestiionId") REFERENCES "Question"("QuestionId");


--
-- Name: FK_Question_QT; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "QuestionTopic"
    ADD CONSTRAINT "FK_Question_QT" FOREIGN KEY ("QuestionId") REFERENCES "Question"("QuestionId");


--
-- Name: FK_Specification_Topic; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Topic"
    ADD CONSTRAINT "FK_Specification_Topic" FOREIGN KEY ("SpecificationCode") REFERENCES "Specification"("SpecificationCode");


--
-- Name: FK_Subject_ExamPaper; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "ExamPaper"
    ADD CONSTRAINT "FK_Subject_ExamPaper" FOREIGN KEY ("SubjectId") REFERENCES "Subject"("SubjectId");


--
-- Name: FK_Subject_Specification; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "Specification"
    ADD CONSTRAINT "FK_Subject_Specification" FOREIGN KEY ("SubjectId") REFERENCES "Subject"("SubjectId");


--
-- Name: FK_Topic_QT; Type: FK CONSTRAINT; Schema: public; Owner: zazhxtzadxftgy
--

ALTER TABLE ONLY "QuestionTopic"
    ADD CONSTRAINT "FK_Topic_QT" FOREIGN KEY ("TopicId") REFERENCES "Topic"("TopicId");


--
-- Name: public; Type: ACL; Schema: -; Owner: zazhxtzadxftgy
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM zazhxtzadxftgy;
GRANT ALL ON SCHEMA public TO zazhxtzadxftgy;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- zazhxtzadxftgyQL database dump complete
--


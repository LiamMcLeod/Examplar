--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.5
-- Dumped by pg_dump version 9.5.1

-- Started on 2016-04-12 01:00:38

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3030 (class 1262 OID 3508958)
-- Name: d4rn8s9s47be39; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE d4rn8s9s47be39 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


\connect d4rn8s9s47be39

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12749)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3032 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 173 (class 1259 OID 3602692)
-- Name: ExamBoard; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "ExamBoard" (
    "ExamBoardName" character varying(20),
    "ExamBoardId" integer NOT NULL
);


--
-- TOC entry 174 (class 1259 OID 3602695)
-- Name: ExamBoard_ExamBoardId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "ExamBoard_ExamBoardId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3033 (class 0 OID 0)
-- Dependencies: 174
-- Name: ExamBoard_ExamBoardId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "ExamBoard_ExamBoardId_seq" OWNED BY "ExamBoard"."ExamBoardId";


--
-- TOC entry 175 (class 1259 OID 3602697)
-- Name: ExamPaper; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 176 (class 1259 OID 3602700)
-- Name: ExamPaper_ExamPaperId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "ExamPaper_ExamPaperId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3034 (class 0 OID 0)
-- Dependencies: 176
-- Name: ExamPaper_ExamPaperId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "ExamPaper_ExamPaperId_seq" OWNED BY "ExamPaper"."ExamPaperId";


--
-- TOC entry 177 (class 1259 OID 3602702)
-- Name: Examiner; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Examiner" (
    "ExamPaperId" integer,
    "ExaminerNote" text,
    "QuestionNo" integer,
    "ExaminerId" integer NOT NULL
);


--
-- TOC entry 178 (class 1259 OID 3602708)
-- Name: Level; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Level" (
    "LevelTitle" character varying(20),
    "LevelId" integer NOT NULL
);


--
-- TOC entry 179 (class 1259 OID 3602711)
-- Name: Level_LevelId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Level_LevelId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3035 (class 0 OID 0)
-- Dependencies: 179
-- Name: Level_LevelId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Level_LevelId_seq" OWNED BY "Level"."LevelId";


--
-- TOC entry 180 (class 1259 OID 3602713)
-- Name: Question; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 181 (class 1259 OID 3602719)
-- Name: QuestionExamPaper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "QuestionExamPaper" (
    "QuestiionId" integer,
    "ExamPaperId" integer
);


--
-- TOC entry 182 (class 1259 OID 3602722)
-- Name: QuestionExaminer_ExaminerId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "QuestionExaminer_ExaminerId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3036 (class 0 OID 0)
-- Dependencies: 182
-- Name: QuestionExaminer_ExaminerId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "QuestionExaminer_ExaminerId_seq" OWNED BY "Examiner"."ExaminerId";


--
-- TOC entry 183 (class 1259 OID 3602724)
-- Name: QuestionImage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "QuestionImage" (
    "QuestionImageId" integer NOT NULL,
    "QuestionImageData" bytea
);


--
-- TOC entry 184 (class 1259 OID 3602730)
-- Name: QuestionImage_QuestionImage_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "QuestionImage_QuestionImage_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3037 (class 0 OID 0)
-- Dependencies: 184
-- Name: QuestionImage_QuestionImage_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "QuestionImage_QuestionImage_Id_seq" OWNED BY "QuestionImage"."QuestionImageId";


--
-- TOC entry 185 (class 1259 OID 3602732)
-- Name: QuestionTopic; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "QuestionTopic" (
    "TopicId" integer,
    "QuestionId" integer
);


--
-- TOC entry 186 (class 1259 OID 3602735)
-- Name: Question_QuestionId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Question_QuestionId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3038 (class 0 OID 0)
-- Dependencies: 186
-- Name: Question_QuestionId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Question_QuestionId_seq" OWNED BY "Question"."QuestionId";


--
-- TOC entry 187 (class 1259 OID 3602737)
-- Name: Specification; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Specification" (
    "ExamBoardId" integer NOT NULL,
    "LevelId" integer NOT NULL,
    "SubjectId" integer NOT NULL,
    "SpecificationCode" character varying(10) NOT NULL,
    "SpecificationTitle" character varying(50)
);


--
-- TOC entry 188 (class 1259 OID 3602740)
-- Name: Specification_ExamBoardId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Specification_ExamBoardId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3039 (class 0 OID 0)
-- Dependencies: 188
-- Name: Specification_ExamBoardId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Specification_ExamBoardId_seq" OWNED BY "Specification"."ExamBoardId";


--
-- TOC entry 189 (class 1259 OID 3602742)
-- Name: Specification_LevelId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Specification_LevelId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3040 (class 0 OID 0)
-- Dependencies: 189
-- Name: Specification_LevelId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Specification_LevelId_seq" OWNED BY "Specification"."LevelId";


--
-- TOC entry 190 (class 1259 OID 3602744)
-- Name: Specification_SubjectId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Specification_SubjectId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3041 (class 0 OID 0)
-- Dependencies: 190
-- Name: Specification_SubjectId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Specification_SubjectId_seq" OWNED BY "Specification"."SubjectId";


--
-- TOC entry 191 (class 1259 OID 3602746)
-- Name: Subject; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Subject" (
    "SubjectTitle" character varying NOT NULL,
    "SubjectId" integer NOT NULL
);


--
-- TOC entry 192 (class 1259 OID 3602752)
-- Name: Subject_SubjectId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Subject_SubjectId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3042 (class 0 OID 0)
-- Dependencies: 192
-- Name: Subject_SubjectId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Subject_SubjectId_seq" OWNED BY "Subject"."SubjectId";


--
-- TOC entry 193 (class 1259 OID 3602754)
-- Name: Topic; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Topic" (
    "TopicTitle" character varying(100),
    "TopicText" text,
    "TopicId" integer NOT NULL,
    "SpecificationCode" character varying
);


--
-- TOC entry 194 (class 1259 OID 3602760)
-- Name: Topic_TopicId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Topic_TopicId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3043 (class 0 OID 0)
-- Dependencies: 194
-- Name: Topic_TopicId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Topic_TopicId_seq" OWNED BY "Topic"."TopicId";


--
-- TOC entry 2838 (class 2604 OID 3602762)
-- Name: ExamBoardId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ExamBoard" ALTER COLUMN "ExamBoardId" SET DEFAULT nextval('"ExamBoard_ExamBoardId_seq"'::regclass);


--
-- TOC entry 2839 (class 2604 OID 3602763)
-- Name: ExamPaperId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ExamPaper" ALTER COLUMN "ExamPaperId" SET DEFAULT nextval('"ExamPaper_ExamPaperId_seq"'::regclass);


--
-- TOC entry 2840 (class 2604 OID 3602764)
-- Name: ExaminerId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Examiner" ALTER COLUMN "ExaminerId" SET DEFAULT nextval('"QuestionExaminer_ExaminerId_seq"'::regclass);


--
-- TOC entry 2841 (class 2604 OID 3602765)
-- Name: LevelId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Level" ALTER COLUMN "LevelId" SET DEFAULT nextval('"Level_LevelId_seq"'::regclass);


--
-- TOC entry 2842 (class 2604 OID 3602766)
-- Name: QuestionId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Question" ALTER COLUMN "QuestionId" SET DEFAULT nextval('"Question_QuestionId_seq"'::regclass);


--
-- TOC entry 2843 (class 2604 OID 3602767)
-- Name: QuestionImageId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "QuestionImage" ALTER COLUMN "QuestionImageId" SET DEFAULT nextval('"QuestionImage_QuestionImage_Id_seq"'::regclass);


--
-- TOC entry 2844 (class 2604 OID 3602768)
-- Name: ExamBoardId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Specification" ALTER COLUMN "ExamBoardId" SET DEFAULT nextval('"Specification_ExamBoardId_seq"'::regclass);


--
-- TOC entry 2845 (class 2604 OID 3602769)
-- Name: LevelId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Specification" ALTER COLUMN "LevelId" SET DEFAULT nextval('"Specification_LevelId_seq"'::regclass);


--
-- TOC entry 2846 (class 2604 OID 3602770)
-- Name: SubjectId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Specification" ALTER COLUMN "SubjectId" SET DEFAULT nextval('"Specification_SubjectId_seq"'::regclass);


--
-- TOC entry 2847 (class 2604 OID 3602771)
-- Name: SubjectId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Subject" ALTER COLUMN "SubjectId" SET DEFAULT nextval('"Subject_SubjectId_seq"'::regclass);


--
-- TOC entry 2848 (class 2604 OID 3602772)
-- Name: TopicId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Topic" ALTER COLUMN "TopicId" SET DEFAULT nextval('"Topic_TopicId_seq"'::regclass);


--
-- TOC entry 3004 (class 0 OID 3602692)
-- Dependencies: 173
-- Data for Name: ExamBoard; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "ExamBoard" VALUES ('AQA', 1);
INSERT INTO "ExamBoard" VALUES ('WJEC', 2);
INSERT INTO "ExamBoard" VALUES ('Edexcel', 3);


--
-- TOC entry 3044 (class 0 OID 0)
-- Dependencies: 174
-- Name: ExamBoard_ExamBoardId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"ExamBoard_ExamBoardId_seq"', 1, true);


--
-- TOC entry 3006 (class 0 OID 3602697)
-- Dependencies: 175
-- Data for Name: ExamPaper; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "ExamPaper" VALUES (1, 6, 1, 'Summer', '2014-06-02', 'COMP1', 1);
INSERT INTO "ExamPaper" VALUES (1, 6, 1, 'Summer', '2014-06-09', 'COMP2', 2);
INSERT INTO "ExamPaper" VALUES (1, 7, 1, 'Summer', '2014-06-17', 'COMP3', 3);


--
-- TOC entry 3045 (class 0 OID 0)
-- Dependencies: 176
-- Name: ExamPaper_ExamPaperId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"ExamPaper_ExamPaperId_seq"', 3, true);


--
-- TOC entry 3008 (class 0 OID 3602702)
-- Dependencies: 177
-- Data for Name: Examiner; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "Examiner" VALUES (1, 'The topics covered by this question were generally well-understood. Most students were able to answer parts 1-2 and 5-6 well, though a number of students gave an answer of 74 instead of -74 as the answer for part 2. For part 3, most students were not able to state the correct range with the most common wrong answer being an upper limit of 128 (rather than 127). Many students did not read the question carefully for part 4 and assumed that four bits were being used before the binary point when the question said three bits before the binary point. A number of students also did not read the question carefully for part 7 and gave answers involving the use of binary addition.', 1, 1);
INSERT INTO "Examiner" VALUES (1, 'The definitions of algorithm were normally worth one mark, with only a few students going on to make a second creditworthy point. The decision table in part 9 was answered well, and most students were able to get some marks on part 10. Even when students had successfully completed part 10 they were often unable to work out what the purpose of the algorithm was – a  number of students were clearly guessing with calculating prime numbers (an answer to a dry run question on a previous COMP1 exam), binary numbers and Hamming code being commonly-seen incorrect answers', 2, 2);
INSERT INTO "Examiner" VALUES (1, 'Students found this question considerably harder than the other questions in Section A. Most students could state at least one other component of a well-defined problem for part 14 but for part 13 a lot of answers described the given of this particular problem instead of defining what was meant by the given of a problem. 6 was the most common wrong answer for part 18 as a number of students assumed that the sort would be in ascending order. Few students scored good marks on part 19, descriptions were often poorly-written or demonstrated no understanding of the bubble sort algorithm.', 3, 3);
INSERT INTO "Examiner" VALUES (1, 'Most students got reasonable marks on this question. Less able students sometimes got confused between the \< and \> operators and a number of students only compared the suits of the two cards – forgetting to compare for rank equality', 7, 7);
INSERT INTO "Examiner" VALUES (1, 'Answers to Section C were often of poor quality and very few students achieved good marks on this question. A number of students are still including additional code when asked for the name of an identifier (parts 23-25). This means that they are not getting the marks for these questions as they have not made it clear which entity is the identifier (sometimes there is more than one identifier in lines of code that they have copied from the Skeleton Program).<br>
<br>
Most students were able to identify that NoOfCardsTurnedOver was a stepper role variable but fewer were able to correctly identify the roles of Choice and SwapSpace. Many answers made it clear that the problem with the algorithm had been identified for part 29 but fewer were able to describe the changes that needed to be made to correct the problem. For part 31, search was the most frequently seen answer which was not worth a mark.', 5, 5);
INSERT INTO "Examiner" VALUES (1, 'This was a fairly straightforward programming question with most students getting good marks. Some students did not read the question carefully and created a selection structure instead of a loop that would repeatedly get a value from the user until a valid value was entered. A number of answers were seen where a recursive solution was attempted but the name entered was not actually returned to the calling routine.<br>
<br>
A significant number of students did not complete the test specified in the question, often entering their own name as test data.', 6, 6);
INSERT INTO "Examiner" VALUES (1, 'Most students did well on this question, with well-over half getting 15 or more marks out of 18.<br>
<br>
Students need to be aware that an algorithm is not the same as a program and that simply copying the algorithm into their development environment will not result in a working program in any of the COMP1 programming languages – the pseudo-code needs to be adapted to match the syntax of the programming language they are using. As in previous years, a number of students simply copied parts of the algorithm into their program code eg trying to use a keyword of OUTPUT or students using VB.Net adding the word DO to their WHILE loops. These appeared to be less able students who generally struggled on the Section D programming as well.<br>
<br>
 Students who found this question difficult were often unable to create an array in the programming language they were using.', 4, 4);
INSERT INTO "Examiner" VALUES (1, 'This was a more challenging question and was a good discriminator between students. It was pleasing to see some interesting answers to this question where able students had clearly thought through the problem and come up with their own method for solving it under exam conditions.<br>
<br>
Most students were able to adapt the code so that it would allow a joker to be played, though a number did not attempt to write code that would limit the number of jokers that could be played.', 8, 8);
INSERT INTO "Examiner" VALUES (1, 'It was disappointing that a large number of students did not include any attempt at answering the question. There was a mark available just for creating a correctly-named subroutine (even if the subroutine did not do anything or use any parameters) and a mark for displaying a message (even if the message did not include the calculated probability). Students should be encouraged to include partial solutions to questions they have not been able to answer wholly successfully. <br>
<br>
As was the case for the last few years, less able students often struggled to create a new subroutine even though there are numerous examples of subroutines in the Skeleton Program. Again, a number of students developed a solution that would correctly calculate the probability but just included code inside the subroutine that displayed this value rather than setting up a mechanism to return the calculated number to the calling routine.', 9, 9);
INSERT INTO "Examiner" VALUES (2, 'Overall, candidates continue to demonstrate a good understanding of logic and Boolean algebra.<br>
<br>
For part (a) candidates demonstrated a secure knowledge of the basic logic gates with around
75% achieving the two marks. A few candidates struggled with the NAND gate.<br>
<br>
The majority of candidates secured full marks for part (b) which asked for a logic circuit to be
connected up. It was pleasing to see that candidates could identify the symbols for each logic gate
and follow a relatively complex equation.<br>
<br>
The simplification of a Boolean expression remains a challenging part of the paper with around a
third of students not managing to secure any marks. Completing a logic table perhaps enabled
weaker students to pick up some of the marks and should be a skill candidates can switch to if they
find Boolean algebra too challenging. A third of candidates secured all of the marks and from their
working it was clear that they could apply De Morgan''s laws effectively and then factorise out a
common element.', 2, 11);
INSERT INTO "Examiner" VALUES (2, 'The content of part (a) has appeared in a similar format in a previous paper and a third of students
achieved 2 or 3 marks for this question part. Candidates who secured marks could clearly
distinguish what performance changes would occur in a way that was precise and tied in to how a
computer works. Answers such as ''the computer would be faster'' did not gain a mark when
thinking about increasing the clock speed as this does not contain the depth that is expected from
an AS-level candidate. Discussing how more instructions would be executed per unit time did
secure the mark. Candidates also seemed confused over the address bus with answers along the
lines of being able to get more memory addresses per unit time rather than discussing that an
increase in the width of the address bus would lead to the CPU being able to access more
addressable memory locations.<br>
<br>
Part (b) was based around I/O controllers, which is an area of the specification that has not been
asked about previously. It was obvious that candidates did struggle with part (b) and this could be
due to it being a topic that has not actually been taught or a topic that has only been covered very
briefly.<br>
<br>
A lot of candidates could describe what a peripheral was and secured the mark for this section.
Candidates who talked about a component outside of the processor did not secure the mark as this
could also include main memory which is not considered to be a peripheral.<br>
<br>
A group of candidates could discuss the role of the I/O port in terms of allowing data to be
transferred from the peripheral to the CPU. Others talked about allowing communication between
peripheral and CPU and this also secured the mark.<br>
<br>
As this topic proved to be hard not many candidates could describe another part of the I/O
controller. Those that could generally talked about electronics allowing the connection to the
system bus or considered the electronics necessary to connect the peripheral to an actual physical
port.<br>
<br>
Part (b) (iv) was a question that candidates attempted and many successfully secured marks. A
popular reason, that was allowed for a mark, was the idea that it might slow down the processor. It
was pleasing to see stronger candidates talk about the idea of a peripheral operating at a slower
speed than the processor and some talked about the need for a buffer. The idea of a peripheral
working at a different voltage to the processor was another popular reason that secured a mark.', 3, 12);
INSERT INTO "Examiner" VALUES (2, 'Part (a) was based around a given URL and asked candidates to identify parts of this URL and
then to state the top-level domain. Questions have been asked previously about breaking down a
URL into parts and candidates generally made a good attempt at answering this. It should be noted
that the question asked candidates to ''describe'' and this would generally mean that an answer should be formed into a sentence rather than just one or two words. The protocol section is
understood by a lot of candidates but the FQDN (fully qualified domain name) does seem to cause
problems. The distinction between a domain name and a fully qualified domain name does appear
to be an area of weakness at the moment.<br>
<br>
Part (b) asked questions around the Domain Name System (DNS) and it is clear that a certain
group of candidates have a good understanding of what DNS is and how it works whilst others
have no awareness of this topic. This is an area that would hopefully be taught with students
actually performing name lookup queries and considering how domains are registered and settings
propagated around the Internet. Candidates with an awareness of this topic could explain that the
DNS server would respond to a domain name query with the IP address currently allocated to that
domain name. They could then also identify a situation when a DNS query would not need to be
sent. It was pleasing to see an understanding of DNS results being cached on a local computer
and even seeing some candidates talking about a hosts file. It was also common to see answers
such as moving to another page on the website or another page/resource on the same domain. A
few candidates seem to think that the DNS server holds the actual web pages and returns those to
the client or that it is the DNS server that then connects you to a website. It was decided that a
resource being on an intranet was not an acceptable answer on its own for part (b) (ii) as some
kind of DNS query might need to be sent or what the candidate was trying to express was covered
elsewhere in the mark scheme. We also decided that IP was not enough for IP address for part (b)
question parts. Candidates that answered that a DNS sever returns an IP or that you would not
need to send a DNS query if you entered an IP did therefore not secure marks.<br>
<br>
Part (c) was based around HTTP GET requests and it was pleasing to see that a group of
candidates could clearly apply their understanding to these question parts. Part (i) was answered
correctly by the majority of candidates and it was clear that it was understood that a browser would
be operating in the application layer. Weaker candidates could not supply the correct name of any
of the TCP/IP layers. It was pleasing to see that candidates understood that an initial HTTP GET
request could just return a HTML file and when processed this might need more HTTP GET
requests to retrieve necessary resources such as images, javascript and CSS files to display a
web page.<br>
<br>
Part (c) (iii) proved hard for candidates to secure a mark and a lot just described a port number and
not a client port number therefore not describing what made it a client one. It was pleasing to see
the correct answer of a temporary port number being supplied for the duration of a connection
being supplied by a few candidates. There does seem to be some confusion around client port
numbers with candidates indicating that it can identify a machine on a local network or that the
server actually supplies the number to the client.', 5, 14);
INSERT INTO "Examiner" VALUES (2, 'Part (a) was answered well by the majority of candidates. It is evident that candidates can link a
piece of legislation to a given situation. The legislation that caused a few candidates to stumble
was the Regulation of Investigatory Powers Act and how this could apply to a request to hand over
an encryption key.<br>
<br>
Part (b) was based around the context of having a system for taking car park charges through the
use of CCTV and mobile phones. It is important for candidates to keep in mind the context of
questions when answering as it was common to see very general points made whilst better
answers were clearly tied back to the context.<br>
<br>
Part (i) came out harder to answer than expected. Around a quarter of candidates responded with
the correct answer of optical character recognition. It was evident that a lot of candidates did not
know what OCR stood for and we saw a variety of imaginative responses.<br>
<br>
Part (ii) has been asked before on previous papers but candidates did struggle to secure the mark
this year. We are looking for personal data to be about a living person who can be identified from
that data. A few candidates did not secure the mark because they missed out the distinction that
the person must be living. Weaker candidates just provided examples of personal data.<br>
<br>
Part (iii) was looking for candidates to use the context of the question to provide some reasons for
privacy campaigners to be concerned about regarding this system. It was pleasing to see that a
group of candidates could identify that the data stored might have the potential to be used to track
the location of people. Another common and accepted answer was that the data could be sold on
and then the mobile numbers could be used for cold calling. The idea of data not being kept
securely was also a valid response and secured a mark.', 7, 16);
INSERT INTO "Examiner" VALUES (3, 'In Part 1 (a) candidates were expected to apply their knowledge of parallel and serial transmission
to identify which was most appropriate in three different scenarios. Candidates appeared to find
this a more difficult task than to state properties or advantages of the different methods, which is
what questions have focused on in previous papers. Almost all students were able to achieve one
mark and over a third achieved full marks.<br>
<br>
Part 1 (b) was well tackled, with over two thirds of students managing to achieve the mark. The
most common correct response was that a handshake would be used to check if a device was
ready to receive data. Some students gave responses that related to the use of handshakes on
networks that were also creditworthy. Answers that suggested that the data payload would be
transmitted as part of the handshake were not awarded any marks.<br>
<br>
Part 1 (c) was also well tackled, with over two thirds of students managing to achieve the mark.
Some students gave a generic description of latency and some defined it in terms of data
transmission, which was the context used in the question. A small number failed to achieve a mark
by giving a response that mixed up the two types of response, such as “It is the delay between
data being transmitted and its effects being felt”.', 1, 17);
INSERT INTO "Examiner" VALUES (3, 'Overall, students demonstrated a good understanding of the use of regular expressions.
For part 2 (a), students needed to explain that the expression would accept any string that
consisted of zero or more b characters followed by a c. Common mistakes were to confuse the +
and * operators and therefore to state that one or more b characters would be required, and to
apply the * operator to the c to its right rather than the b to its left. Some students wrote “any
number of b characters” which was not enough for a mark. It had to be made clear that zero or
more characters were required to achieve the mark.<br>
<br>
For part 2 (b), students needed to explain that the expression would accept any string that
consisted of zero or one b characters followed by a c. Many candidates simply listed the two
strings that would be accepted, which were bc and b, which was an acceptable alternative
response. Some candidates confused the meaning of the ? operator with either the + or the |
operators.<br>
<br>
The simplest correct response to part 2 (c) was b(cd)*(e|fg), although any valid regular expression
was creditworthy. Some students missed marks by using the wrong operator instead of the * or by
missing out brackets which were important for defining the scope of the operators. Three quarters
of students got some marks for this question part and half got full marks.', 2, 18);
INSERT INTO "Examiner" VALUES (3, 'The overwhelming majority of students were able to correctly identify that it was the binary search
algorithm that required the list to be sorted for part 3 (a). The trace for part 3 (b) was also well
completed with about three quarters of students getting some marks and well over half getting full
marks.<br>
<br>
For part 3 (c), around half of the candidates were correctly able to explain that the value of
InnerPointer did not decrease to zero because either the second while loop condition was not satisfied or the number being moved did not need to be inserted at the start of the list. The most
common mistake was to state that the list had already been sorted, which was not enough for a
mark.<br>
<br>
For part 3 (d), about two thirds of students correctly identified that the algorithm that they had
traced was of time complexity O(n<sup>2</sup>).<br>
<br>
Part 3 (e) was poorly answered, with only about one third of students correctly identifying that the
algorithm they had traced was an insertion sort. Bubble sort was a far more common but incorrect
response.<br>
<br>
Parts 3 (f) (i), 3 (f) (ii) and 3 (g) were all well answered. The most common error in both parts of 3
(f) was to perform a traversal of the tree instead of using it as a binary search tree.', 3, 19);
INSERT INTO "Examiner" VALUES (3, 'Question part 8 (a) asked students to explain what inheritance was. Just under two thirds of
students were able to do this. Those students who failed to achieve the mark usually did not make
clear that the relationship was between a parent class and a sub class or, if they did this correctly,
failed to explain the nature of the relationship, ie that the sub class could share some of the
methods or properties of the parent.<br>
<br>
Students had to draw an inheritance diagram in part 8 (b). Almost 90% of candidates achieved at
least two of the three available marks, but only half of the candidates achieved full marks. The
failure to achieve the third mark was usually because a candidate failed to style the diagram
correctly, either not drawing arrowheads, drawing them at the wrong end of the lines, or not
enclosing the names of the classes in some type of box.<br>
<br>
A very good range of responses was made to question part 8 (c). The most common mistakes that
students made were to fail to identify that the new class was a sub class of the Selector class, to
fail to redefine the SelectItemFromList procedure so that it was overridden, to add in extra
unnecessary functions and procedures, and to redefine the data items from the parent class.', 8, 24);
INSERT INTO "Examiner" VALUES (3, 'Part 5 (a) was well tackled with over two thirds of candidates recognising that a queue was an
appropriate data structure to represent the deck of cards because it was a first-in-first out structure.
Just over half of the candidates were able to correctly update the pointers to the queue in part 5 (b)
(i) and just under half were able to do likewise in part 5 (b) (ii). In the former, the most common
mistakes were to change FrontPointer to 10 instead of 11 and to leave QueueSize at 52. In the
latter, the most common mistake was to change RearPointer to 54, failing to recognise that this
was a circular queue and RearPointer should change to 2.<br>
<br>
Students achieved a broad range of marks on question part 5 (b) (iii) which required them to write
an algorithm for dealing a card. Over two thirds got some marks, but just under 10% scored full
marks. The most commonly made mistakes were to try to deal more than one card, to fail to wrap
FrontPointer back to the start of the array when it went past the end of it, and to deal a card when
the deck was empty.<br>
<br>
Part 5 (c) was well answered, with most students recognising that in an event-driven program,
subroutines would be associated with events, such as a button being clicked or a timer reaching 0,
and that the appropriate subroutine would be called when the event occurred. Some responses
were not considered creditworthy as they could have applied to any style of programming, for
example “the program waits for user input before executing instructions”.<br>
<br>
Approximately two thirds of students achieved some marks for comparing a mobile phone
operating system and a desktop operating system in part 5 (d). A common mistake was to
compare the devices rather than the operating systems, for example stating that the desktop would
have more memory that the mobile phone. Many students explained that the mobile phone OS
would have lower hardware requirements but it would have been nice to see some more concrete
examples of these reduced requirements, and phrases such as “smaller” and “more lightweight”
were used too often. Some students gave responses to a question from an earlier paper that were
not appropriate for this scenario.', 5, 21);
INSERT INTO "Examiner" VALUES (3, 'Overall, students demonstrated a satisfactory ability to use SQL in question parts 6 (a) to (c).
Part 6 (a) was the worst tackled of the three. Commonly made mistakes when defining the table in
this part were to use incorrect SQL data types, to include the field EngineSize, to declare
RegistrationNumber to be an integer or to use non-SQL syntax. Some students attempted to put a
constraint on the PolicyType to ensure that it could only be one of the two valid possibilities.
Students were not expected to know how to do this, so incorrect attempts at doing so were not
penalised.<br>
<br>
In part 6 (b), just under half of students got full marks. Many students did not appear to really know
the correct syntax of the SQL Update command, but achieved an easy mark by writing the first line
of the command as “Update Vehicle”. A common mistake was to fail to put quotation marks around
the registration number or colour values.<br>
<br>
Responses to part 6 (c) were disappointing, given the frequency that students have been asked to
write SQL queries in the exam over the years, and the fact that this was a fairly simple example,
involving only two tables. Only one third of candidates achieved full marks, though half managed to
achieve three of the four marks. As in part 6 (b), one common mistake was to miss quotation
marks around the registration number. Other mistakes were to use the keyword GET instead of
SELECT and to miss out the AND operator in the WHERE clause. Pleasingly, most students
realised that a condition was needed to link the two tables together.<br>
<br>
Parts 6 (d) (i) to (iii) were about server side scripts. Just under half of candidates were able to
achieve full marks for part (i) by explaining that a server side script was program code that was
executed on a server. Some also recognised that the trigger for this could be the requesting of a
web page and that the output would be a web page. Part (ii) was the least well tackled part, with
only around one third of students achieving any marks. The Request object is used to fetch userinputted
data from the web server that it will have been sent when the web page that the data was
entered on was submitted. The majority of students believed that the Request object was used to either query a database or that the execution of the command would trigger a request to the user
to input data at that time rather than retrieving already input data. Almost all of the candidates got
one of the two marks for part (iii) but few clearly explained that the output would be written to a web
page which the web server would return to the web browser on the Police Officer’s handheld
terminal.<br>
<br>
Part 6 (e) was about extending the design of the database to store safety certificate information.
The majority of candidates scored at least two of the three marks. Most candidates correctly
identified that a new table would need to be created, what the fields in this table would need to be,
and that CertificateNumber would be the primary key. Those candidates who scored two but not
three marks usually made a mistake with regard to how the new table would be linked to the
existing database, stating that the CertificateNumber would be added to the Vehicle table as a
foreign key. This solution would not work as this would only allow one certificate to be associated
with each vehicle, and it was required that previous certificates could also be stored. The correct
solution was to put the RegistrationNumber from the Vehicle table into the new table as a foreign
key.', 6, 22);
INSERT INTO "Examiner" VALUES (3, 'More than half of the candidates were able to correctly define abstraction in part 7 (a). The
question was asked in the context of data representation, so an appropriate definition would have
been to store only those details of a problem/model that were required in the context of the
problem being solved. Common mistakes were to state that unnecessary complexity would be
hidden from the user, rather than being removed from the model altogether, or to define a
simulation instead of abstraction.<br>
<br>
Part 7 (b) was the question that assessed quality of written communication. As such, it was
particularly important the candidates used technical terms accurately when writing their responses.
Almost all candidates covered both aspects of the question: the representation as a graph and the
representation using arrays as an adjacency matrix or list.<br>
<br>
In almost all responses, the graph part of the answer was better than the array representation part,
with most students being able to correctly explain how the underground railway network could be
represented as a graph. Some students lost marks by not using the correct terminology or by
drawing diagrams but not explaining points such as that a station would be represented as a node.<br>
<br>
As the question paper stated, diagrams needed to be fully explained if they were used. A common
mistake was to state that stations would be represented by nodes and that railway tracks would be
represented by vertices; vertex in a synonym for node but was being mistakenly used instead of
the term edge or arc. A small but not insignificant number of students misinterpreted the term
graph and explained how the network might be represented as a bar chart or scattergraph.<br>
<br>
The part of the question relating to the representation using arrays as an adjacency matrix or list
was poorly tackled. Many students discussed how the representation could be drawn out as a grid
or list on paper instead of how it could be represented using arrays in a programming language, or
described solutions that were not really either an adjacency matrix or list.<br>
<br>
Those who decided to represent the data as an adjacency matrix often suggested that the station
names would be written into the array rather than that stations would be associated with a number
that would be used as an index into the array. That said, pleasingly, most students who suggested
a matrix representation recognised that the distances would be filled into the array at the appropriate location and that a null value would be used where there was no route. Some students
used an array containing only 0s and 1s instead of distances.<br>
<br>
Students who chose to present an adjacency list solution rarely explained how this would be
achieved in a programming language, focussing instead on how it could be depicted
diagrammatically. Another common mistake was to talk about pointers, without explaining how
these would work in the context of the array.', 7, 23);
INSERT INTO "Examiner" VALUES (3, 'Question parts 10 (a) (i) to (iii) all required students to determine IP addresses. In each part,
approximately three quarters of students did so correctly. Common mistakes were to write IP addresses that were formed from three octets instead of four, to write IP addresses that were not
appropriate for the segment or to give a value of 0 for the last octet of an IP address.<br>
<br>
Part 10 (b) was well tackled with the vast majority of students achieving at least one mark and just
under half achieving both marks. Many students discussed collisions or the effects of cable failure.
Students who missed out on the second mark usually did so because they failed to explain their
answer in enough technical detail.<br>
<br>
Parts 10 (c) (i) and (ii) were about Software as a Service, or SaaS. The vast majority of students
achieved one mark on each part, although only just over a third achieved both marks for part (i).
For part (i), the most commonly seen correct responses related to the fact that the software could
be used on Internet-connected computers outside of the office and that the hardware requirements
would be lower for SaaS. Some candidates made good points about the company not having to
update the software, but others mistakenly suggested that the company would only have to update
the software once, confusing SaaS with a thin client system. With SaaS, the company would not
have to update the software at all as this would be handled by the provider of the SaaS. For part
(ii), the most commonly seen correct response was that unreliability of the Internet connection or
service would make the software inaccessible.<br>
<br>
Part 10 (d) was poorly tackled, with just under half of students achieving any marks. The most
commonly seen correct response was that a LAN would use baseband and a WAN broadband.
Other valid responses included that a LAN would have faster transmission speeds and lower
latency than a WAN and that more security issues might need to be dealt with on a WAN. Some
students compared the communication media that would be used. Those who did so in detail often
achieved a mark, but many made vague or incorrect points such as that a LAN would be wireless
and a WAN wired. Some students assumed that a WAN and the Internet were the same thing and
gave responses relating to IP addresses that did not really answer the question.', 10, 26);
INSERT INTO "Examiner" VALUES (2, 'In part 1 (a), candidates were expected to complete a figure representing the classifications of
various types of software. Over half of the candidates achieved three or more marks for this part.
Candidates should be reminded that answers such as ''Microsoft Word document'' will not be
accepted as generic terms such as word processor are required. The most challenging item for
candidates to identify was translator software.<br>
<br>
Part 1 (b) was well tackled with a good number of candidates securing all of the marks. For part (i)
a few candidates provided the answer ''assembler'' which was not accepted as the name for the
second generation of programming language. The majority of candidates either answered with
assembly code or assembly language which both secured the mark. Part (ii) was also generally
well known, but there was confusion over what would be used to translate the assembly code into
machine code. Most candidates secured at least one mark, but if they then discussed compiler or
interpreters they did not secure the second mark which was for mentioning assembler. Part (iii)
was found to be slightly more challenging and around 40% of candidates secured the mark. Good
answers talked about differences between processors or the architecture of machines with a few
including detailed examples. Weaker responses demonstrated some confusion over what the
meaning of executable and discussed problems in the actual program itself, for example a bug in
the code.', 1, 10);
INSERT INTO "Examiner" VALUES (2, 'Part (a) was answered very well by candidates with the majority responding with keyboard and
touch-sensitive screen as manual input methods for a barcode. A few candidates responded with
mouse as one of their devices and this was not accepted as this would not be an appropriate input
device, with the context of a supermarket checkout. Weaker responses also included a variety of
scanning devices and just plain monitor / VDU.<br>
<br>
Part (b) provided candidates with a good opportunity to demonstrate an understanding of the
principles of operation of a bar-code scanner. It was pleasing to see candidates structure their
work well and provide clear statements about a light source, the reflection of light, the sensing of
the reflection and the conversion of this into an appropriate digital form.
The role of the check digit was less well known and this separated the candidates by marks
achieved. It was pleasing to see that candidates could describe how a function would be applied to
the first 12 digits to generate a digit which would then be compared to the original check digit. For
some candidates there was confusion as to what a check digit actually was and a few decided to
talk about parity and the numbers of 1s and 0s in the binary. Weaker candidates spent time
discussing the looking up of a product in a database to find the details and also sometimes
included some discussion around stock control.', 4, 13);
INSERT INTO "Examiner" VALUES (2, 'This question examined HTML and CSS and was generally answered well by candidates.<br>
<br>
Part (a) was answered well by candidates but it did prove hard to secure all three marks. A lot of
candidates understood that the text needed to be between HTML tags but struggled to remember
that it was \<a\> and \</a\> giving instead a variety of other tags. Stronger candidates remembered
the \<a\> tag but it was rare to actually see the syntax completed correctly, often the URL would be
missing the http:// section. As creating hyperlinks is a core part of web page design it was perhaps
surprising to see how candidates struggled to write the HTML required.<br>
<br>
Part (b) allowed the majority of candidates to secure a mark as they could clearly distinguish the
difference between the styling of an un-ordered list and an ordered list. Candidates who just
described the lists as ordered and un-ordered did not secure the mark as this did not provide
enough information as to how they would look. A few candidates also described \<ul\> incorrectly as
underline and others indicated it would centre the text.<br>
<br>
Part (c) allowed the majority of candidates to secure at least one mark with a good number
securing both marks. Candidates who clearly separated the lines of text and made the text ''on the
mat'' clearly larger allowed the marking points to be easily identified. It should be noted that none
of the tags in the question would actually change the contents of the text. Candidates who put in an
extra capital O for ''on the mat'' were not penalised but candidates should be careful when copying
the text.<br>
<br>
Part (d) again allowed the majority of candidates to secure a mark as they spotted the missing
\</title\> tag in the provided HTML code.<br>
<br>
Part € allowed candidates with a greater understanding of CSS usage to explain carefully how
CSS could be used for responsive web design. Good answers included using percentages for
controlling the width of elements and it was also pleasing to see descriptions as to how web pages
tend to switch to a long one column mode when displayed on a mobile device. It was also evident
that candidates understood how different CSS could be loaded depending on the client device. A
quick way to see this in action on a responsive website is to scale down the width of the browser
and see how the elements change as different resolutions are hit.', 6, 15);
INSERT INTO "Examiner" VALUES (3, 'As in previous years, candidates demonstrated a very good understanding of floating point
representation.<br>
<br>
Parts 4 (a) and 4 (b) were extremely well tackled, with over three quarters of students achieving full
marks. Part 4 (c) was not tackled as well, with less than half of the candidates achieving both
marks. Some candidates mistakenly moved the binary point four places to the right instead of the
left or miscalculated the exponent to be 12 instead of -4. Others did not know how to deal with the
binary point being moved to the left past the sign bit in a negative number and so ended up with a
positive number instead of a negative number at the end.<br>
<br>
Part 4 (d) was well tackled, with the majority of students achieving full marks and two thirds
achieving at least two of the three marks. Those students who did not achieve full marks most
commonly went wrong when converting 108 in unsigned binary into -108 in two’s complement.
Another mistake was to write out the binary place values backwards when working out the bit
pattern for 108, ie 1,2,4,8 etc.<br>
<br>
The vast majority of candidates achieved at least one mark for part 4 (e), correctly recognising that
overflow occurred when a value was too large to be stored in the number of bits available. The
clearest answers explicitly stated that the number of bits available for storing the number was
insufficient, rather than making more vague references to, for example, memory space. Some
students failed to achieve a mark because they related the number of bits to the mantissa alone.
Around two thirds of candidates were able to identify correctly that the situation which might cause
overflow was division for part 4 (f).', 4, 20);
INSERT INTO "Examiner" VALUES (3, 'Question part 9 (a) was a trace of the execution of a Turing machine. This was very well tackled
with over three quarters of students achieving full marks.<br>
<br>
Part 9 (b) required students to explain the overall effect of three of the rules of the Turing
machine’s transition function. The overall effect was that the tape head would move right along the
string until the end of the string was found, without changing the contents of the tape. When the
end of the string was located, the state would change to S<sub>CO</sub> and the head would move left. The
most common mistake that students made was to explain what each individual rule did rather than
what the purpose of the rules taken together was.<br>
<br>
Part 9 (c) was poorly tacked, with only slightly over a quarter of students achieving any marks. A
universal Turing machine can be seen to work as an interpreter because it reads instructions in
order from a tape and executes them in sequence. This is similar to how an interpreter reads
instructions in order from memory and executes them in sequence. Many students either defined
what a universal Turing machine was, or answered the question that has been asked on a previous
paper about the importance of them.', 9, 25);


--
-- TOC entry 3009 (class 0 OID 3602708)
-- Dependencies: 178
-- Data for Name: Level; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "Level" VALUES ('Level 1', 1);
INSERT INTO "Level" VALUES ('Level 2', 2);
INSERT INTO "Level" VALUES ('Level 3', 3);
INSERT INTO "Level" VALUES ('Level 4', 4);
INSERT INTO "Level" VALUES ('Level 5', 5);
INSERT INTO "Level" VALUES ('AS', 6);
INSERT INTO "Level" VALUES ('A2', 7);
INSERT INTO "Level" VALUES ('A-Level', 8);


--
-- TOC entry 3046 (class 0 OID 0)
-- Dependencies: 179
-- Name: Level_LevelId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Level_LevelId_seq"', 1, false);


--
-- TOC entry 3011 (class 0 OID 3602713)
-- Dependencies: 180
-- Data for Name: Question; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "Question" VALUES (1, 3, 'What is the range of <strong>denary</strong> numbers that can be represented using <strong>8-bit two’s
complement binary integers</strong>?', '-128; to (+)127;<br>
<strong>Mark as follows:</strong><br>
Lowest value identified correctly;<br>
Highest value identified correctly;<br>', 2, 0, 3, 1);
INSERT INTO "Question" VALUES (2, 7, '!Simplify ADD the following expression.<br>
<br>{
<table><td style="border-top: solid 1px #000; padding-top:2px"><span style="text-decoration:overline">A</span> + <span style="text-decoration:overline">B</span></td><td style="padding-top:3px"> + B·<span style="text-decoration:overline">A</span></td></table><br>}
<br>
Show each stage of your working. <strong>[2 marks]</strong><br>
<br>
Final answer. <strong>[1 mark]</strong>', '<strong>MAX 2 if working is not logically sound</strong><br>
<br>
<strong>Example 1:</strong><br>
<br>
<table style="border-spacing:0px;"><td style="border-top:solid 1px #000; padding-top:2px"><span style="text-decoration:overline">A</span> + <span style="text-decoration:overline">B</span></td><td> + B·<span style="text-decoration:overline">A</span></td></table>
<br>
<table><td style="border-top:solid 1px #000; padding-top:2px">A·B + B·<span style="text-decoration:overline">A</span></td><td></td></table>
Having applied De Morgan''s correctly;<br>
<br>
<table><td>B·(A + <span style="text-decoration:overline">A</span>)</td></table>
Having factorised;<br>
<br>
<strong>Final answer: B</strong>;<br>
<br>
<br>
<strong>Example 2:</strong><br>
<br>
<table><td style="border-top:solid 1px #000; padding-top:2px"><span style="text-decoration:overline">A</span> + <span style="text-decoration:overline">B</span></td><td> + B·<span style="text-decoration:overline">A</span></td></table>
<br>
<table><td style="border-top:solid 1px #000; padding-top:2px">(<span style="text-decoration:overline">A</span> + <span style="text-decoration:overline">B</span>)·(<span style="text-decoration:overline">B</span> + A)</td></table>
Having applied De Morgan''s correctly;<br>
<br>
<table><td style="border-top:solid 1px #000; padding-top:2px"><span style="text-decoration:overline">A</span>·<span style="text-decoration:overline">B</span> + <span style="text-decoration:overline">A</span>·A + <span style="text-decoration:overline">B</span>·<span style="text-decoration:overline">B</span> + <span style="text-decoration:overline">B</span>·A</td></table>
Expanded bracket;<br>
<br>
<table><td style = "border-top:solid 1px #000; padding-top:2px"><span style="text-decoration:overline">A</span>·<span style="text-decoration:overline">B</span> + 0 + <span style="text-decoration:overline">B</span> + <span style="text-decoration:overline">B</span>·A</td></table>
Simplified elements<br>
<br>
<table><td style="border-top:solid 1px #000; padding-top:2px"><span style="text-decoration:overline">A</span>·<span style="text-decoration:overline">B</span> + <span style="text-decoration:overline">B</span></td></table>
Having used C + C·D = C to simplify<br>
<br>
<table><td style="border-top:solid 1px #000; padding-top"><span style="text-decoration:overline">B</span></td></table>
Having used C + C·D = C to simplify again<br>
<br>
<strong>Final answer: B</strong>;', 3, 0, 48, 11);
INSERT INTO "Question" VALUES (1, 6, 'Why are bit patterns often displayed using hexadecimal instead of binary?', 'Easier for people to read/understand; <strong>R.</strong> If implication is it easier for a
computer to read/understand<br>
Can be displayed using fewer digits;<br>
More compact when printed/displayed;<br>
<strong>NE.</strong> Takes up less space<br>
<strong>NE.</strong> More compact', 1, 0, 6, 1);
INSERT INTO "Question" VALUES (1, 1, 'If the bit pattern in <strong>Figure 1</strong> is an <strong>unsigned binary integer</strong>, what is the denary
equivalent of this bit pattern?', '182;', 1, 1, 1, 1);
INSERT INTO "Question" VALUES (1, 2, 'If the bit pattern in <strong>Figure 1</strong> is a <strong>two’s complement binary integer</strong>, what is the denary
equivalent of this bit pattern?', '-;74;', 2, 1, 2, 1);
INSERT INTO "Question" VALUES (1, 4, 'If the bit pattern in <strong>Figure 1</strong> is an <strong>unsigned binary fixed point</strong> number with 3 bits
before and 5 bits after the binary point, what is the denary equivalent of this bit pattern?', '5 11/16 //<br>
5.6875;;<br>
<br>
<strong>A.</strong> 91 ÷ 16;;<br>
<br>
<strong>Mark as follows:</strong><br>
Correct whole number part (5);<br>
Correct fractional/decimal part (11/16 or 0.6875);<br>', 2, 1, 4, 1);
INSERT INTO "Question" VALUES (1, 5, 'What is the <strong>hexadecimal</strong> equivalent of the bit pattern in <strong>Figure 1</strong>?', 'B;6;', 2, 1, 5, 1);
INSERT INTO "Question" VALUES (1, 7, 'Describe a method that can, without the use of binary addition, multiply any <strong>unsigned
binary integer</strong> by the binary number 10 (the denary number 2).', 'Shift all the bits one place to the left; and add a zero //<br>
Add an extra 0; to the RHS of the bit pattern; //<br>
<br>
<strong>A.</strong> Arithmetic left shift applied once / by one place;;', 2, 0, 7, 1);
INSERT INTO "Question" VALUES (1, 8, 'Explain what is meant by an <strong>algorithm</strong>.', 'A (step-by-step) description of how to complete a task / a description of a
process that achieves some task / a sequence of steps that solve a
problem / A sequence of unambiguous instructions for solving a problem;<br>
<br>
Independent of any programming language;<br>
That can be completed in finite time;<br>', 2, 0, 8, 2);
INSERT INTO "Question" VALUES (1, 16, 'What should be written in box <strong>(b)</strong> in <strong>Figure 4</strong>?', 'L [Count2]  <-  L [Count2  +  1];<br>
<br>
<strong>A.</strong> Any answer where meaning is clear', 1, 2, 16, 3);
INSERT INTO "Question" VALUES (1, 9, 'Complete <strong>Table 1</strong> so that it shows the actions to be taken when the conditions have
particular values: an ''X'' symbol should be placed in the relevant shaded cells to indicate
the action that will be executed for the given conditions. Some of the shaded cells will
need to be left empty.', '<table style="border-collapse:collapse; border-spacing:0; background-color:#BFBFBF;">
  <tr>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;vertical-align:top">   </th>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;vertical-align:top">   </th>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;vertical-align:top"> X </th>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;vertical-align:top"> X </td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;vertical-align:top"> X </td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;vertical-align:top">   </td>
  </tr>
</table>
<br>
<br>
<strong>Marks as follows:</strong><br>
1 mark for any two correct columns;<br>
2 marks for all three columns correct;<br>
<br>
<strong>A.</strong> Other, sensible, indicators instead of X', 2, 2, 9, 2);
INSERT INTO "Question" VALUES (1, 10, 'Dry run the algorithm in <strong>Figure 2</strong> by completing <strong>Table 2</strong>. The first row has been
 completed for you.', '<table style="border-collapse:collapse;border-spacing:0;">
  <tr>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;background-color:#BFBFBF;text-align:center;vertical-align:top">x</th>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;background-color:#BFBFBF;text-align:center;vertical-align:top">c</th>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;background-color:#BFBFBF;text-align:center;vertical-align:top">b</th>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;background-color:#BFBFBF;text-align:center;vertical-align:top">a</th>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;background-color:#BFBFBF;text-align:center;vertical-align:top">Printed<br>output</th>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top;background-color:#BFBFBF;">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top;background-color:#BFBFBF;">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top;background-color:#BFBFBF;">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top;background-color:#BFBFBF;">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top;background-color:#BFBFBF;">000</td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">001</td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">2</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">011</td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">3</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">010</td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">4</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">110</td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">5</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">111</td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">6</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">101</td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">7</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center;vertical-align:top">100</td>
  </tr>
</table>
<br>
<br>
<strong>Mark as follows:</strong><br>
Any one row containing the correct values for <strong>c</strong>, <strong>b</strong>, and <strong>a</strong>;<br>
Any three rows containing the correct values for <strong>c</strong>, <strong>b</strong> and <strong>a</strong>;<br>
All rows contain the correct values for <strong>c</strong>, <strong>b</strong> and <strong>a</strong>;<br>
<strong>x</strong> column correct;<br>
<strong>Printed output</strong> column correct; <strong>A.</strong>  printed output column incorrect – but
matches the (incorrect) values provided for <strong>c</strong>, <strong>b</strong> and <strong>a</strong>, as long as a
minimum of 3 rows have been completed<br>
<br>
<strong>I.</strong> Extra row at start of table containing the values <strong>0</strong>, <strong>0</strong>, <strong>0</strong>, <strong>0</strong>, <strong>000</strong>', 5, 2, 10, 2);
INSERT INTO "Question" VALUES (1, 11, 'Explain, precisely, the purpose of the algorithm in <strong>Figure 2</strong>.', 'Print the (first 8) Gray code numbers; //<br>
(3 bit) Gray code counter;<br>
<br>
<strong>NE</strong> Convert to Gray code', 1, 2, 11, 2);
INSERT INTO "Question" VALUES (1, 12, 'Describe the <strong>goal</strong> of this problem.', 'Sort the list of numbers // Sort <strong>L</strong>;', 1, 2, 12, 3);
INSERT INTO "Question" VALUES (1, 13, 'What is meant by the <strong>given</strong> of a problem?', 'The initial situation;', 1, 0, 13, 3);
INSERT INTO "Question" VALUES (1, 14, 'The given and the goal are two components of a well-defined problem. State <strong>two</strong> other
components of a well-defined problem.', 'Ownership;<br>
Resources;<br>
Constraints;', 2, 0, 14, 3);
INSERT INTO "Question" VALUES (1, 15, 'How should the curved arrow <strong>(a)</strong> in <strong>Figure 4</strong> be labelled?', 'FOR  Count2<-  1  TO  (MAX  –  1);<br>
<br>
<strong>A.</strong> Any answer where meaning is clear', 1, 2, 15, 3);
INSERT INTO "Question" VALUES (1, 18, 'A <strong>new</strong> Bubble Sort routine is developed using the structure chart shown in <strong>Figure 4</strong>.<br>
<br>
What value will be in <strong>L [1]</strong> when <strong>this</strong> Bubble Sort routine has finished executing on the
array <strong>L</strong> shown in <strong>Figure 3</strong>?', '63;', 1, 2, 18, 3);
INSERT INTO "Question" VALUES (1, 17, 'What should be written in box <strong>(c)</strong> in <strong>Figure 4</strong>?', 'L [Count2  +  1]  <-  Temp;<br>
<br>
<strong>A.</strong> Any answer where meaning is clear', 1, 2, 17, 3);
INSERT INTO "Question" VALUES (1, 19, 'A Bubble Sort routine, based on the structure chart in <strong>Figure 4</strong>, always completes
<strong>MAX  -  1</strong> passes through the array. Often, this number of passes is not required, as the
contents of the array will be sorted after fewer passes have been made.<br>
<br>
If a pass is made through the array during which no swaps need to be made then the
array has been sorted.<br>
<br>
Describe the changes that need to be made to the Bubble Sort routine so that it will only
complete the minimum number of passes through the array that are needed to fully sort
the contents of the array.', 'Set <strong>SwapMade</strong> to have a value of <strong>False</strong> before the inner loop starts;<br>
If a swap is made then set <strong>SwapMade</strong> to <strong>True</strong>;<br>
Change the <span style="text-decoration:underline">outer loop</span> so that it keeps on repeating until <strong>SwapMade</strong>
equals <strong>False</strong>;<br>
<br>
<strong>Note:</strong> if neither of the first two mark points have been awarded 1 mark
should be awarded for the idea of creating a flag / Boolean variable<br>
<br>
<strong>Alternative answer</strong><br>
Set <strong>NoMoreSwaps</strong> to have a value of <strong>True</strong> <span style="text-decoration:underline">before the inner loop starts</span>;<br>
If a swap is made then set <strong>NoMoreSwaps</strong> to <strong>False</strong>;<br>
Change the <span style="text-decoration:underline">outer loop</span> so that it keeps on repeating until <strong>NoMoreSwaps</strong> equals <strong>True</strong>;<br>
<br>
<strong>Note:</strong> if neither of the first two mark points have been awarded 1 mark
should be awarded for the idea of creating a flag / Boolean variable<br>
<br>
<strong>Alternative answer</strong><br>
Set <strong>NoOfSwaps</strong> to have a value of <strong>0</strong> <span style="text-decoration:underline">before the inner loop starts</span>;<br>
If a swap is made then increment <strong>NoMoreSwaps</strong>;<br>
Change the <span style="text-decoration:underline">outer loop</span> so that it keeps on repeating until <strong>NoMoreSwaps</strong> equals <strong>0</strong>;<br>
<br>
<strong>Note:</strong> if neither of the first two mark points have been awarded 1 mark
should be awarded for the idea of creating a counter variable<br>
<br>
<br>
<strong>A.</strong> any sensible identifier<br>
<strong>A.</strong> no identifier specified<br>
<strong>A.</strong> alternative sensible data type<br>
<strong>A.</strong> pseudo-code answers', 3, 2, 19, 3);
INSERT INTO "Question" VALUES (2, 3, 'A program written in a second generation programming language has been loaded into
a computer. In this form it cannot be directly executed on this computer.<br>
<br>
What has to be done to make an executable form of the program, which can be directly
executed by this computer, and what would be used, typically, to do this?', 'has to be translated into <span style="text-decoration:underline">machine code</span> // each assembly language instruction will be translated into <span style="text-decoration:underline">machine code</span> equivalent;<br>
<br>
by an assembler;<br>
<br>
<strong>A.</strong> converted for translated<br>
<strong>A.</strong> first generation for machine code', 2, 0, 44, 10);
INSERT INTO "Question" VALUES (2, 2, 'Machine code is the first generation of programming language.<br>
 What is the second generation of programming language?', 'assembly (language);<br>
<strong>A.</strong> assembly code<br>
<br>
<strong>R.</strong> assembler', 1, 0, 43, 10);
INSERT INTO "Question" VALUES (2, 4, 'A programmer then finds that when the executable form of the program is transferred unaltered to another computer, the program does not run and an error message is displayed.<br>
<br>
Why might the executable form of the program not be able to run on this computer?', 'Because it does not have the same processor (type) // the instruction set is different // different architecture/platform;<br>
<br>
(Assembled / linked for a) different operating system;<br>
<br>
<strong>NE.</strong> operating software<br>
<br>
The program refers to a memory address that does not exist on this computer // relocatable code used but addressing system on new machine different;<br>
<br>
not enough memory space;<br>
required peripherals are not available;<br>
required <span style="text-decoration:underline">library</span> (code/program) missing;', 1, 0, 45, 10);
INSERT INTO "Question" VALUES (2, 1, 'Complete <strong>Figure 1</strong> by suggesting labels for the boxes numbered 1 to 4 in the diagram.<br>', '<pre class="answerpre">
1	special purpose (application software);<br>
	<strong>A.</strong> specific purpose<br>
	<strong>R.</strong> special (software)/specialist (software)<br>
<br>
2	word processor // spreadsheet // presentation software/program // database;<br>
	<strong>A.</strong> any other sensible answer<br>
	<strong>R.</strong> (web) browser<br>
	<strong>R.</strong> text editor<br>
<br>
3	translator (software/program);<br>
	<strong>A.</strong> translating/translation<br>
<br>
4	utility (software/program);<br>
	<strong>R.</strong> just trade name of a specific piece of software unless used as an example (ie MS Word)
</pre>', 4, 2, 42, 10);
INSERT INTO "Question" VALUES (2, 5, '!Complete the truth tables for the following logic gates.<br>
<br>
<strong>OR gate</strong><br>
<strong>NAND gate</strong><br>
<br>{
<table style="border-collapse:collapse;border-spacing:0;">
  <tr>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;text-align:center">Input A</th>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;text-align:center">Input B</th>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;text-align:center">Output</th>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center"></td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center"></td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center"></td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center"></td>
  </tr>
</table>}', 'OR gate<br>
<br>
<table style="border-collapse:collapse;border-spacing:0;">
  <tr>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;text-align:center">Input A</th>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;text-align:center">Input B</th>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;text-align:center">Output</th>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
  </tr>
</table><br>
<br>
NAND gate<br>
<br>
<table style="border-collapse:collapse;border-spacing:0;">
  <tr>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;text-align:center">Input A</th>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;text-align:center">Input B</th>
    <th style="font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;font-weight:bold;text-align:center">Output</th>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
  </tr>
  <tr>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">1</td>
    <td style="font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;text-align:center">0</td>
  </tr>
</table><br>
<br>
One mark for correct output OR gate;<br>
One mark for correct output NAND gate;', 2, 0, 46, 11);
INSERT INTO "Question" VALUES (2, 6, '!Represent the following Boolean equation as a logic circuit by completing <strong>Figure 2</strong>.<br>
<br>{
<table><td>Q = </td><td style="border-top:solid 1px #000;padding:2px"><span style="text-decoration:overline">A·B</span> + B·C</td></table>}', '<img src="/public/img/questions/NOIMG.PNG"><br>
<br>
One mark for inputs A and B connected to AND gate;<br>
<br>
One mark for inputs B and C connected to AND gate;<br>
<br>
One mark for output of AND (A,B input) as only connection going to NOT gate;<br>
<br>
One mark for output of NOT gate plus the AND gate (B,C input) going to OR gate;<br>
<br>
One mark OR gate as only connection going to NOT gate and output only connection to Q;', 5, 2, 47, 11);
INSERT INTO "Question" VALUES (3, 2, 'Data communication often uses a handshaking protocol.
 Explain one purpose of a handshaking protoco', 'To check that a (receiving) device is connected;
To check that a (receiving) device is ready to receive data // to
inform a (transmitting) device that a (receiving) device is/is not
ready to receive data;
To tell a (receiving) device that data is ready to be transmitted;
To negotiate/agree how the transmission will take place // to
agree the system to be used for transmission ; A. an example of
a setting that might be agreed during a handshake eg bit rate,
parity
To ensure successful communication;', 1, 2, 73, 1);
INSERT INTO "Question" VALUES (3, 1, 'For each row in Table 1, place a tick in one column to indicate whether the
transmission is most likely to be serial, most likely to be parallel or could be either serial
or parallel.', 'http://filestore.aqa.org.uk/subjects/AQA-COMP3-W-MS-JUN14.PDF', 3, 2, 72, 1);


--
-- TOC entry 3012 (class 0 OID 3602719)
-- Dependencies: 181
-- Data for Name: QuestionExamPaper; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "QuestionExamPaper" VALUES (1, 1);
INSERT INTO "QuestionExamPaper" VALUES (2, 1);
INSERT INTO "QuestionExamPaper" VALUES (3, 1);
INSERT INTO "QuestionExamPaper" VALUES (4, 1);
INSERT INTO "QuestionExamPaper" VALUES (5, 1);
INSERT INTO "QuestionExamPaper" VALUES (6, 1);
INSERT INTO "QuestionExamPaper" VALUES (7, 1);
INSERT INTO "QuestionExamPaper" VALUES (8, 1);
INSERT INTO "QuestionExamPaper" VALUES (9, 1);
INSERT INTO "QuestionExamPaper" VALUES (10, 1);


--
-- TOC entry 3047 (class 0 OID 0)
-- Dependencies: 182
-- Name: QuestionExaminer_ExaminerId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"QuestionExaminer_ExaminerId_seq"', 3, true);


--
-- TOC entry 3014 (class 0 OID 3602724)
-- Dependencies: 183
-- Data for Name: QuestionImage; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "QuestionImage" VALUES (1, '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');
INSERT INTO "QuestionImage" VALUES (2, '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');
INSERT INTO "QuestionImage" VALUES (0, '0\000');


--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 184
-- Name: QuestionImage_QuestionImage_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"QuestionImage_QuestionImage_Id_seq"', 2, true);


--
-- TOC entry 3016 (class 0 OID 3602732)
-- Dependencies: 185
-- Data for Name: QuestionTopic; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "QuestionTopic" VALUES (1, 1);
INSERT INTO "QuestionTopic" VALUES (1, 2);
INSERT INTO "QuestionTopic" VALUES (1, 3);
INSERT INTO "QuestionTopic" VALUES (1, 4);
INSERT INTO "QuestionTopic" VALUES (1, 5);
INSERT INTO "QuestionTopic" VALUES (1, 6);
INSERT INTO "QuestionTopic" VALUES (1, 7);
INSERT INTO "QuestionTopic" VALUES (2, 8);
INSERT INTO "QuestionTopic" VALUES (2, 9);
INSERT INTO "QuestionTopic" VALUES (2, 10);
INSERT INTO "QuestionTopic" VALUES (2, 11);
INSERT INTO "QuestionTopic" VALUES (2, 12);
INSERT INTO "QuestionTopic" VALUES (2, 13);
INSERT INTO "QuestionTopic" VALUES (2, 14);
INSERT INTO "QuestionTopic" VALUES (2, 15);
INSERT INTO "QuestionTopic" VALUES (2, 16);
INSERT INTO "QuestionTopic" VALUES (2, 17);
INSERT INTO "QuestionTopic" VALUES (2, 18);
INSERT INTO "QuestionTopic" VALUES (2, 19);
INSERT INTO "QuestionTopic" VALUES (5, 42);
INSERT INTO "QuestionTopic" VALUES (5, 43);
INSERT INTO "QuestionTopic" VALUES (5, 44);
INSERT INTO "QuestionTopic" VALUES (5, 45);
INSERT INTO "QuestionTopic" VALUES (5, 46);
INSERT INTO "QuestionTopic" VALUES (5, 47);
INSERT INTO "QuestionTopic" VALUES (5, 48);
INSERT INTO "QuestionTopic" VALUES (2, 72);
INSERT INTO "QuestionTopic" VALUES (2, 73);


--
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 186
-- Name: Question_QuestionId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Question_QuestionId_seq"', 23, true);


--
-- TOC entry 3018 (class 0 OID 3602737)
-- Dependencies: 187
-- Data for Name: Specification; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "Specification" VALUES (1, 6, 2, '7516', 'AS Level Computer Science');
INSERT INTO "Specification" VALUES (1, 8, 1, '2510', 'AS and A-Level Computing');
INSERT INTO "Specification" VALUES (1, 8, 3, '2520', 'AS and A-Level ICT');
INSERT INTO "Specification" VALUES (1, 7, 2, '7517', 'A-Level Computer Science');


--
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 188
-- Name: Specification_ExamBoardId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Specification_ExamBoardId_seq"', 2, true);


--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 189
-- Name: Specification_LevelId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Specification_LevelId_seq"', 7, true);


--
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 190
-- Name: Specification_SubjectId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Specification_SubjectId_seq"', 8, true);


--
-- TOC entry 3022 (class 0 OID 3602746)
-- Dependencies: 191
-- Data for Name: Subject; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "Subject" VALUES ('Computing', 1);
INSERT INTO "Subject" VALUES ('Computer  Science', 2);
INSERT INTO "Subject" VALUES ('ICT', 3);
INSERT INTO "Subject" VALUES ('IT', 4);


--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 192
-- Name: Subject_SubjectId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Subject_SubjectId_seq"', 1, false);


--
-- TOC entry 3024 (class 0 OID 3602754)
-- Dependencies: 193
-- Data for Name: Topic; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "Topic" VALUES ('Data Representation', NULL, 1, '2510');
INSERT INTO "Topic" VALUES ('Problem Solving', NULL, 2, '2510');
INSERT INTO "Topic" VALUES ('Programming', NULL, 3, '2510');
INSERT INTO "Topic" VALUES ('Practical Exercise', NULL, 4, '2510');
INSERT INTO "Topic" VALUES ('Computer Components', NULL, 5, '2510');
INSERT INTO "Topic" VALUES ('The Stored Program Concept', NULL, 6, '2510');
INSERT INTO "Topic" VALUES ('The Internet', NULL, 7, '2510');


--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 194
-- Name: Topic_TopicId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Topic_TopicId_seq"', 2, true);


--
-- TOC entry 2850 (class 2606 OID 3602774)
-- Name: PK_ExamBoard; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ExamBoard"
    ADD CONSTRAINT "PK_ExamBoard" PRIMARY KEY ("ExamBoardId");


--
-- TOC entry 2855 (class 2606 OID 3602776)
-- Name: PK_ExamPaper; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ExamPaper"
    ADD CONSTRAINT "PK_ExamPaper" PRIMARY KEY ("ExamPaperId");


--
-- TOC entry 2857 (class 2606 OID 3602778)
-- Name: PK_Examiner; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Examiner"
    ADD CONSTRAINT "PK_Examiner" PRIMARY KEY ("ExaminerId");


--
-- TOC entry 2859 (class 2606 OID 3602780)
-- Name: PK_Level; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Level"
    ADD CONSTRAINT "PK_Level" PRIMARY KEY ("LevelId");


--
-- TOC entry 2864 (class 2606 OID 3602782)
-- Name: PK_Question; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Question"
    ADD CONSTRAINT "PK_Question" PRIMARY KEY ("QuestionId");


--
-- TOC entry 2868 (class 2606 OID 3602784)
-- Name: PK_QuestionImage; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "QuestionImage"
    ADD CONSTRAINT "PK_QuestionImage" PRIMARY KEY ("QuestionImageId");


--
-- TOC entry 2875 (class 2606 OID 3602786)
-- Name: PK_Specification; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Specification"
    ADD CONSTRAINT "PK_Specification" PRIMARY KEY ("SpecificationCode");


--
-- TOC entry 2877 (class 2606 OID 3602788)
-- Name: PK_Subject; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Subject"
    ADD CONSTRAINT "PK_Subject" PRIMARY KEY ("SubjectId");


--
-- TOC entry 2880 (class 2606 OID 3602790)
-- Name: PK_Topic; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Topic"
    ADD CONSTRAINT "PK_Topic" PRIMARY KEY ("TopicId");


--
-- TOC entry 2851 (class 1259 OID 3602791)
-- Name: FKI_ExamBoard_ExamPaper; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_ExamBoard_ExamPaper" ON "ExamPaper" USING btree ("ExamBoardId");


--
-- TOC entry 2871 (class 1259 OID 3602792)
-- Name: FKI_ExamBoard_Specification; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_ExamBoard_Specification" ON "Specification" USING btree ("ExamBoardId");


--
-- TOC entry 2865 (class 1259 OID 3602793)
-- Name: FKI_ExamPaper_EPQ; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_ExamPaper_EPQ" ON "QuestionExamPaper" USING btree ("ExamPaperId");


--
-- TOC entry 2860 (class 1259 OID 3602794)
-- Name: FKI_ExamPaper_Question; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_ExamPaper_Question" ON "Question" USING btree ("ExamPaperId");


--
-- TOC entry 2861 (class 1259 OID 3602795)
-- Name: FKI_Examiner_Question; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_Examiner_Question" ON "Question" USING btree ("ExaminerId");


--
-- TOC entry 2852 (class 1259 OID 3602796)
-- Name: FKI_Level_ExamPaper; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_Level_ExamPaper" ON "ExamPaper" USING btree ("LevelId");


--
-- TOC entry 2872 (class 1259 OID 3602797)
-- Name: FKI_Level_Specification; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_Level_Specification" ON "Specification" USING btree ("LevelId");


--
-- TOC entry 2862 (class 1259 OID 3602798)
-- Name: FKI_QuestionImage_Question; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_QuestionImage_Question" ON "Question" USING btree ("QuestionImageId");


--
-- TOC entry 2866 (class 1259 OID 3602799)
-- Name: FKI_Question_EPQ; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_Question_EPQ" ON "QuestionExamPaper" USING btree ("QuestiionId");


--
-- TOC entry 2869 (class 1259 OID 3602800)
-- Name: FKI_Question_QT; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_Question_QT" ON "QuestionTopic" USING btree ("QuestionId");


--
-- TOC entry 2878 (class 1259 OID 3602801)
-- Name: FKI_Specification_Topic; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_Specification_Topic" ON "Topic" USING btree ("SpecificationCode");


--
-- TOC entry 2853 (class 1259 OID 3602802)
-- Name: FKI_Subject_ExamPaper; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_Subject_ExamPaper" ON "ExamPaper" USING btree ("SubjectId");


--
-- TOC entry 2873 (class 1259 OID 3602803)
-- Name: FKI_Subject_Specification; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_Subject_Specification" ON "Specification" USING btree ("SubjectId");


--
-- TOC entry 2870 (class 1259 OID 3602804)
-- Name: FKI_Topic_QT; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "FKI_Topic_QT" ON "QuestionTopic" USING btree ("TopicId");


--
-- TOC entry 2881 (class 2606 OID 3602805)
-- Name: FK_ExamBoard_ExamPaper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ExamPaper"
    ADD CONSTRAINT "FK_ExamBoard_ExamPaper" FOREIGN KEY ("ExamBoardId") REFERENCES "ExamBoard"("ExamBoardId");


--
-- TOC entry 2891 (class 2606 OID 3602810)
-- Name: FK_ExamBoard_Specification; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Specification"
    ADD CONSTRAINT "FK_ExamBoard_Specification" FOREIGN KEY ("ExamBoardId") REFERENCES "ExamBoard"("ExamBoardId");


--
-- TOC entry 2887 (class 2606 OID 3602815)
-- Name: FK_ExamPaper_EPQ; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "QuestionExamPaper"
    ADD CONSTRAINT "FK_ExamPaper_EPQ" FOREIGN KEY ("ExamPaperId") REFERENCES "ExamPaper"("ExamPaperId");


--
-- TOC entry 2884 (class 2606 OID 3602820)
-- Name: FK_ExamPaper_Question; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Question"
    ADD CONSTRAINT "FK_ExamPaper_Question" FOREIGN KEY ("ExamPaperId") REFERENCES "ExamPaper"("ExamPaperId");


--
-- TOC entry 2885 (class 2606 OID 3602825)
-- Name: FK_Examiner_Question; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Question"
    ADD CONSTRAINT "FK_Examiner_Question" FOREIGN KEY ("ExaminerId") REFERENCES "Examiner"("ExaminerId");


--
-- TOC entry 2882 (class 2606 OID 3602830)
-- Name: FK_Level_ExamPaper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ExamPaper"
    ADD CONSTRAINT "FK_Level_ExamPaper" FOREIGN KEY ("LevelId") REFERENCES "Level"("LevelId");


--
-- TOC entry 2892 (class 2606 OID 3602835)
-- Name: FK_Level_Specification; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Specification"
    ADD CONSTRAINT "FK_Level_Specification" FOREIGN KEY ("LevelId") REFERENCES "Level"("LevelId");


--
-- TOC entry 2886 (class 2606 OID 3602840)
-- Name: FK_QuestionImage_Question; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Question"
    ADD CONSTRAINT "FK_QuestionImage_Question" FOREIGN KEY ("QuestionImageId") REFERENCES "QuestionImage"("QuestionImageId");


--
-- TOC entry 2888 (class 2606 OID 3602845)
-- Name: FK_Question_EPQ; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "QuestionExamPaper"
    ADD CONSTRAINT "FK_Question_EPQ" FOREIGN KEY ("QuestiionId") REFERENCES "Question"("QuestionId");


--
-- TOC entry 2889 (class 2606 OID 3602850)
-- Name: FK_Question_QT; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "QuestionTopic"
    ADD CONSTRAINT "FK_Question_QT" FOREIGN KEY ("QuestionId") REFERENCES "Question"("QuestionId");


--
-- TOC entry 2894 (class 2606 OID 3602855)
-- Name: FK_Specification_Topic; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Topic"
    ADD CONSTRAINT "FK_Specification_Topic" FOREIGN KEY ("SpecificationCode") REFERENCES "Specification"("SpecificationCode");


--
-- TOC entry 2883 (class 2606 OID 3602860)
-- Name: FK_Subject_ExamPaper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ExamPaper"
    ADD CONSTRAINT "FK_Subject_ExamPaper" FOREIGN KEY ("SubjectId") REFERENCES "Subject"("SubjectId");


--
-- TOC entry 2893 (class 2606 OID 3602865)
-- Name: FK_Subject_Specification; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Specification"
    ADD CONSTRAINT "FK_Subject_Specification" FOREIGN KEY ("SubjectId") REFERENCES "Subject"("SubjectId");


--
-- TOC entry 2890 (class 2606 OID 3602870)
-- Name: FK_Topic_QT; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "QuestionTopic"
    ADD CONSTRAINT "FK_Topic_QT" FOREIGN KEY ("TopicId") REFERENCES "Topic"("TopicId");


--
-- TOC entry 3031 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM zazhxtzadxftgy;
GRANT ALL ON SCHEMA public TO zazhxtzadxftgy;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-04-12 01:01:02

--
-- PostgreSQL database dump complete
--


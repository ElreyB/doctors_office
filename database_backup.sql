--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

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
-- Name: doctors; Type: TABLE; Schema: public; Owner: elreybelmonti
--

CREATE TABLE doctors (
    id integer NOT NULL,
    name character varying,
    specialty_id integer
);


ALTER TABLE doctors OWNER TO elreybelmonti;

--
-- Name: doctors_id_seq; Type: SEQUENCE; Schema: public; Owner: elreybelmonti
--

CREATE SEQUENCE doctors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE doctors_id_seq OWNER TO elreybelmonti;

--
-- Name: doctors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elreybelmonti
--

ALTER SEQUENCE doctors_id_seq OWNED BY doctors.id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: elreybelmonti
--

CREATE TABLE patients (
    id integer NOT NULL,
    name character varying,
    birthday date,
    doctor_id integer
);


ALTER TABLE patients OWNER TO elreybelmonti;

--
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: elreybelmonti
--

CREATE SEQUENCE patients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE patients_id_seq OWNER TO elreybelmonti;

--
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elreybelmonti
--

ALTER SEQUENCE patients_id_seq OWNED BY patients.id;


--
-- Name: specialties; Type: TABLE; Schema: public; Owner: elreybelmonti
--

CREATE TABLE specialties (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE specialties OWNER TO elreybelmonti;

--
-- Name: specialties_id_seq; Type: SEQUENCE; Schema: public; Owner: elreybelmonti
--

CREATE SEQUENCE specialties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE specialties_id_seq OWNER TO elreybelmonti;

--
-- Name: specialties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elreybelmonti
--

ALTER SEQUENCE specialties_id_seq OWNED BY specialties.id;


--
-- Name: doctors id; Type: DEFAULT; Schema: public; Owner: elreybelmonti
--

ALTER TABLE ONLY doctors ALTER COLUMN id SET DEFAULT nextval('doctors_id_seq'::regclass);


--
-- Name: patients id; Type: DEFAULT; Schema: public; Owner: elreybelmonti
--

ALTER TABLE ONLY patients ALTER COLUMN id SET DEFAULT nextval('patients_id_seq'::regclass);


--
-- Name: specialties id; Type: DEFAULT; Schema: public; Owner: elreybelmonti
--

ALTER TABLE ONLY specialties ALTER COLUMN id SET DEFAULT nextval('specialties_id_seq'::regclass);


--
-- Data for Name: doctors; Type: TABLE DATA; Schema: public; Owner: elreybelmonti
--

COPY doctors (id, name, specialty_id) FROM stdin;
\.


--
-- Name: doctors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: elreybelmonti
--

SELECT pg_catalog.setval('doctors_id_seq', 1, false);


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: elreybelmonti
--

COPY patients (id, name, birthday, doctor_id) FROM stdin;
\.


--
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: elreybelmonti
--

SELECT pg_catalog.setval('patients_id_seq', 1, false);


--
-- Data for Name: specialties; Type: TABLE DATA; Schema: public; Owner: elreybelmonti
--

COPY specialties (id, name) FROM stdin;
\.


--
-- Name: specialties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: elreybelmonti
--

SELECT pg_catalog.setval('specialties_id_seq', 1, false);


--
-- Name: doctors doctors_pkey; Type: CONSTRAINT; Schema: public; Owner: elreybelmonti
--

ALTER TABLE ONLY doctors
    ADD CONSTRAINT doctors_pkey PRIMARY KEY (id);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: elreybelmonti
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- Name: specialties specialties_pkey; Type: CONSTRAINT; Schema: public; Owner: elreybelmonti
--

ALTER TABLE ONLY specialties
    ADD CONSTRAINT specialties_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--


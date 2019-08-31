--
-- PostgreSQL database dump
--

-- Dumped from database version 10.9 (Ubuntu 10.9-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.9 (Ubuntu 10.9-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
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


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: arefundedby; Type: TABLE; Schema: public; Owner: benue
--

CREATE TABLE public.arefundedby (
    campaignid integer NOT NULL,
    donor character varying(255) NOT NULL,
    datereceived character varying(255) NOT NULL
);


ALTER TABLE public.arefundedby OWNER TO benue;

--
-- Name: buildings; Type: TABLE; Schema: public; Owner: benue
--

CREATE TABLE public.buildings (
    address character varying(255) NOT NULL,
    landlord character varying(255),
    rent integer
);


ALTER TABLE public.buildings OWNER TO benue;

--
-- Name: campaigns; Type: TABLE; Schema: public; Owner: benue
--

CREATE TABLE public.campaigns (
    campaignid integer NOT NULL,
    timeframe character varying(255),
    title character varying(255),
    budget integer,
    CONSTRAINT campaigns_budget_check CHECK ((budget > 0))
);


ALTER TABLE public.campaigns OWNER TO benue;

--
-- Name: donations; Type: TABLE; Schema: public; Owner: benue
--

CREATE TABLE public.donations (
    amount integer,
    donor character varying(255) NOT NULL,
    datereceived character varying(255) NOT NULL,
    CONSTRAINT donations_amount_check CHECK ((amount > 0))
);


ALTER TABLE public.donations OWNER TO benue;

--
-- Name: events; Type: TABLE; Schema: public; Owner: benue
--

CREATE TABLE public.events (
    title character varying(255),
    timeframe character varying(255),
    eventsid integer NOT NULL,
    location character varying(255),
    campaignid integer
);


ALTER TABLE public.events OWNER TO benue;

--
-- Name: ispaidby; Type: TABLE; Schema: public; Owner: benue
--

CREATE TABLE public.ispaidby (
    address character varying(255) NOT NULL,
    donor character varying(255) NOT NULL,
    datereceived character varying(255) NOT NULL
);


ALTER TABLE public.ispaidby OWNER TO benue;

--
-- Name: members; Type: TABLE; Schema: public; Owner: benue
--

CREATE TABLE public.members (
    name character varying(255),
    memberid integer NOT NULL,
    note character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.members OWNER TO benue;

--
-- Name: payfor; Type: TABLE; Schema: public; Owner: benue
--

CREATE TABLE public.payfor (
    staffid integer NOT NULL,
    donor character varying(255) NOT NULL,
    datereceived character varying(255) NOT NULL
);


ALTER TABLE public.payfor OWNER TO benue;

--
-- Name: purchases; Type: TABLE; Schema: public; Owner: benue
--

CREATE TABLE public.purchases (
    title character varying(255),
    purchaseid integer NOT NULL,
    price integer,
    campaignid integer
);


ALTER TABLE public.purchases OWNER TO benue;

--
-- Name: staff; Type: TABLE; Schema: public; Owner: benue
--

CREATE TABLE public.staff (
    staffid integer NOT NULL,
    salary integer,
    name character varying(255),
    eventsattended integer,
    islongtime boolean,
    notes character varying(255) DEFAULT NULL::character varying,
    CONSTRAINT staff_check CHECK (((salary > 0) OR ((islongtime = NULL::boolean) AND (eventsattended = NULL::integer)))),
    CONSTRAINT staff_check1 CHECK (((islongtime = true) OR (eventsattended < 3)))
);


ALTER TABLE public.staff OWNER TO benue;

--
-- Name: support; Type: TABLE; Schema: public; Owner: benue
--

CREATE TABLE public.support (
    memberid integer NOT NULL,
    campaignid integer NOT NULL
);


ALTER TABLE public.support OWNER TO benue;

--
-- Name: websitepushlog; Type: TABLE; Schema: public; Owner: benue
--

CREATE TABLE public.websitepushlog (
    pushdate character varying(255),
    phasenumber integer,
    pushid integer NOT NULL,
    campaignid integer
);


ALTER TABLE public.websitepushlog OWNER TO benue;

--
-- Name: workon; Type: TABLE; Schema: public; Owner: benue
--

CREATE TABLE public.workon (
    eventsid integer NOT NULL,
    staffid integer NOT NULL
);


ALTER TABLE public.workon OWNER TO benue;

--
-- Data for Name: arefundedby; Type: TABLE DATA; Schema: public; Owner: benue
--

COPY public.arefundedby (campaignid, donor, datereceived) FROM stdin;
1	Megan	Jan. 1 2019
2	Megan	Jan. 1 2019
3	Megan	Jan. 1 2019
\.


--
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: benue
--

COPY public.buildings (address, landlord, rent) FROM stdin;
1000 Main St.	Sergei	5000
\.


--
-- Data for Name: campaigns; Type: TABLE DATA; Schema: public; Owner: benue
--

COPY public.campaigns (campaignid, timeframe, title, budget) FROM stdin;
1	Jan. 27 2019 - Jan. 30 2019	Green Spirit	8000
2	Feb. 4 2019 - Feb. 16 2019	Mean Green Machines	16000
3	Oct. 1 2019 - Oct. 11 2019	Scream for Green	5000
\.


--
-- Data for Name: donations; Type: TABLE DATA; Schema: public; Owner: benue
--

COPY public.donations (amount, donor, datereceived) FROM stdin;
100500	Ally	Jan. 25 2019
5000	Rick	Sept. 14 2019
1000000	Megan	Jan. 1 2019
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: benue
--

COPY public.events (title, timeframe, eventsid, location, campaignid) FROM stdin;
Green Dash	Jan. 27 2019 - Jan 27. 2019	1	2500 6th Street, New York, New York	1
Green Gathering	Jan. 27 2019 - Jan 29. 2019	2	3700 Dash Street, Los Angeles, California	1
Go Green	Oct. 3 2019 - Oct. 8 2019	3	3230 Green Street, Seattle, Washington	3
\.


--
-- Data for Name: ispaidby; Type: TABLE DATA; Schema: public; Owner: benue
--

COPY public.ispaidby (address, donor, datereceived) FROM stdin;
1000 Main St.	Rick	Sept. 14 2019
\.


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: benue
--

COPY public.members (name, memberid, note) FROM stdin;
Bobby	1	\N
Natasha	2	\N
\.


--
-- Data for Name: payfor; Type: TABLE DATA; Schema: public; Owner: benue
--

COPY public.payfor (staffid, donor, datereceived) FROM stdin;
1	Ally	Jan. 25 2019
4	Ally	Jan. 25 2019
\.


--
-- Data for Name: purchases; Type: TABLE DATA; Schema: public; Owner: benue
--

COPY public.purchases (title, purchaseid, price, campaignid) FROM stdin;
Poster Board	1	5	1
Glue	2	1	1
Markers	3	2	2
Pens	4	3	3
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: benue
--

COPY public.staff (staffid, salary, name, eventsattended, islongtime, notes) FROM stdin;
1	100000	Nick	\N	\N	\N
2	0	Geoff	3	t	\N
3	0	Dre	2	f	\N
4	500	Mark	\N	\N	\N
\.


--
-- Data for Name: support; Type: TABLE DATA; Schema: public; Owner: benue
--

COPY public.support (memberid, campaignid) FROM stdin;
1	2
2	1
\.


--
-- Data for Name: websitepushlog; Type: TABLE DATA; Schema: public; Owner: benue
--

COPY public.websitepushlog (pushdate, phasenumber, pushid, campaignid) FROM stdin;
Jan. 27 2019	1	1	1
Jan. 29 2019	2	2	1
Jan. 30 2019	3	3	1
Feb. 4 2019	1	4	2
Oct. 7 2019	1	5	3
\.


--
-- Data for Name: workon; Type: TABLE DATA; Schema: public; Owner: benue
--

COPY public.workon (eventsid, staffid) FROM stdin;
1	1
2	2
3	3
3	4
\.


--
-- Name: arefundedby arefundedby_pkey; Type: CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.arefundedby
    ADD CONSTRAINT arefundedby_pkey PRIMARY KEY (campaignid, donor, datereceived);


--
-- Name: buildings buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (address);


--
-- Name: campaigns campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (campaignid);


--
-- Name: donations donations_pkey; Type: CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.donations
    ADD CONSTRAINT donations_pkey PRIMARY KEY (donor, datereceived);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (eventsid);


--
-- Name: ispaidby ispaidby_pkey; Type: CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.ispaidby
    ADD CONSTRAINT ispaidby_pkey PRIMARY KEY (address, donor, datereceived);


--
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (memberid);


--
-- Name: payfor payfor_pkey; Type: CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.payfor
    ADD CONSTRAINT payfor_pkey PRIMARY KEY (staffid, donor, datereceived);


--
-- Name: purchases purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY (purchaseid);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (staffid);


--
-- Name: support support_pkey; Type: CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.support
    ADD CONSTRAINT support_pkey PRIMARY KEY (memberid, campaignid);


--
-- Name: websitepushlog websitepushlog_pkey; Type: CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.websitepushlog
    ADD CONSTRAINT websitepushlog_pkey PRIMARY KEY (pushid);


--
-- Name: workon workon_pkey; Type: CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.workon
    ADD CONSTRAINT workon_pkey PRIMARY KEY (eventsid, staffid);


--
-- Name: arefundedby arefundedby_campaignid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.arefundedby
    ADD CONSTRAINT arefundedby_campaignid_fkey FOREIGN KEY (campaignid) REFERENCES public.campaigns(campaignid);


--
-- Name: arefundedby arefundedby_donor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.arefundedby
    ADD CONSTRAINT arefundedby_donor_fkey FOREIGN KEY (donor, datereceived) REFERENCES public.donations(donor, datereceived);


--
-- Name: events events_campaignid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_campaignid_fkey FOREIGN KEY (campaignid) REFERENCES public.campaigns(campaignid);


--
-- Name: ispaidby ispaidby_address_fkey; Type: FK CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.ispaidby
    ADD CONSTRAINT ispaidby_address_fkey FOREIGN KEY (address) REFERENCES public.buildings(address);


--
-- Name: ispaidby ispaidby_donor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.ispaidby
    ADD CONSTRAINT ispaidby_donor_fkey FOREIGN KEY (donor, datereceived) REFERENCES public.donations(donor, datereceived);


--
-- Name: payfor payfor_donor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.payfor
    ADD CONSTRAINT payfor_donor_fkey FOREIGN KEY (donor, datereceived) REFERENCES public.donations(donor, datereceived);


--
-- Name: payfor payfor_staffid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.payfor
    ADD CONSTRAINT payfor_staffid_fkey FOREIGN KEY (staffid) REFERENCES public.staff(staffid);


--
-- Name: purchases purchases_campaignid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_campaignid_fkey FOREIGN KEY (campaignid) REFERENCES public.campaigns(campaignid);


--
-- Name: support support_campaignid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.support
    ADD CONSTRAINT support_campaignid_fkey FOREIGN KEY (campaignid) REFERENCES public.campaigns(campaignid);


--
-- Name: support support_memberid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.support
    ADD CONSTRAINT support_memberid_fkey FOREIGN KEY (memberid) REFERENCES public.members(memberid);


--
-- Name: websitepushlog websitepushlog_campaignid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.websitepushlog
    ADD CONSTRAINT websitepushlog_campaignid_fkey FOREIGN KEY (campaignid) REFERENCES public.campaigns(campaignid);


--
-- Name: workon workon_eventsid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.workon
    ADD CONSTRAINT workon_eventsid_fkey FOREIGN KEY (eventsid) REFERENCES public.events(eventsid);


--
-- Name: workon workon_staffid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: benue
--

ALTER TABLE ONLY public.workon
    ADD CONSTRAINT workon_staffid_fkey FOREIGN KEY (staffid) REFERENCES public.staff(staffid);


--
-- PostgreSQL database dump complete
--


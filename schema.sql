-- The IdleRPG Discord Bot
-- Copyright (C) 2018-2019 Diniboy and Gelbpunkt

-- This software is dual-licensed under the GNU Affero General Public License for non-commercial and the Travitia License for commercial use.
-- For more information, see README.md and LICENSE.md.


--
-- PostgreSQL database dump
--

-- Dumped from database version 11.3
-- Dumped by pg_dump version 11.3

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
-- Name: array_diff(anyarray, anyarray); Type: FUNCTION; Schema: public; Owner: jens
--

CREATE FUNCTION public.array_diff(array1 anyarray, array2 anyarray) RETURNS anyarray
    LANGUAGE sql IMMUTABLE
    AS $$
    select coalesce(array_agg(elem), '{}')
    from unnest(array1) elem
    where elem <> all(array2)
$$;


ALTER FUNCTION public.array_diff(array1 anyarray, array2 anyarray) OWNER TO jens;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: allitems; Type: TABLE; Schema: public; Owner: jens
--

CREATE TABLE public.allitems (
    id bigint NOT NULL,
    owner bigint,
    name character varying(200) NOT NULL,
    value integer NOT NULL,
    type character varying(10) NOT NULL,
    damage numeric(5,2) NOT NULL,
    armor numeric(5,2) NOT NULL
);


ALTER TABLE public.allitems OWNER TO jens;

--
-- Name: allitems_id_seq; Type: SEQUENCE; Schema: public; Owner: jens
--

CREATE SEQUENCE public.allitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.allitems_id_seq OWNER TO jens;

--
-- Name: allitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jens
--

ALTER SEQUENCE public.allitems_id_seq OWNED BY public.allitems.id;


--
-- Name: children; Type: TABLE; Schema: public; Owner: jens
--

CREATE TABLE public.children (
    mother bigint,
    father bigint,
    name character varying(20),
    age bigint,
    gender character varying(10)
);


ALTER TABLE public.children OWNER TO jens;

--
-- Name: guild; Type: TABLE; Schema: public; Owner: jens
--

CREATE TABLE public.guild (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    memberlimit bigint NOT NULL,
    leader bigint,
    icon character varying(60),
    money bigint DEFAULT 0,
    wins bigint DEFAULT 0,
    banklimit bigint DEFAULT 250000,
    badges text[],
    badge character varying(100) DEFAULT NULL::character varying,
    description character varying(200) DEFAULT 'No Description set yet'::character varying NOT NULL
);


ALTER TABLE public.guild OWNER TO jens;

--
-- Name: guild_id_seq; Type: SEQUENCE; Schema: public; Owner: jens
--

CREATE SEQUENCE public.guild_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guild_id_seq OWNER TO jens;

--
-- Name: guild_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jens
--

ALTER SEQUENCE public.guild_id_seq OWNED BY public.guild.id;


--
-- Name: helpme; Type: TABLE; Schema: public; Owner: jens
--

CREATE TABLE public.helpme (
    id bigint NOT NULL
);


ALTER TABLE public.helpme OWNER TO jens;

--
-- Name: inventory; Type: TABLE; Schema: public; Owner: jens
--

CREATE TABLE public.inventory (
    id bigint NOT NULL,
    item bigint,
    equipped boolean NOT NULL
);


ALTER TABLE public.inventory OWNER TO jens;

--
-- Name: inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: jens
--

CREATE SEQUENCE public.inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_id_seq OWNER TO jens;

--
-- Name: inventory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jens
--

ALTER SEQUENCE public.inventory_id_seq OWNED BY public.inventory.id;


--
-- Name: market; Type: TABLE; Schema: public; Owner: jens
--

CREATE TABLE public.market (
    id bigint NOT NULL,
    item bigint,
    price integer NOT NULL
);


ALTER TABLE public.market OWNER TO jens;

--
-- Name: market_id_seq; Type: SEQUENCE; Schema: public; Owner: jens
--

CREATE SEQUENCE public.market_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.market_id_seq OWNER TO jens;

--
-- Name: market_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jens
--

ALTER SEQUENCE public.market_id_seq OWNED BY public.market.id;


--
-- Name: profile; Type: TABLE; Schema: public; Owner: jens
--

CREATE TABLE public.profile (
    "user" bigint NOT NULL,
    name character varying(20),
    money integer,
    xp integer,
    pvpwins bigint DEFAULT 0 NOT NULL,
    crates bigint DEFAULT 0 NOT NULL,
    money_booster bigint DEFAULT 0,
    time_booster bigint DEFAULT 0,
    luck_booster bigint DEFAULT 0,
    marriage bigint DEFAULT 0,
    colour character varying(7) DEFAULT '#FFFFFF'::character varying,
    background character varying(60) DEFAULT 0,
    guild bigint DEFAULT 0,
    class character varying(50) DEFAULT 'No Class'::character varying,
    deaths bigint DEFAULT 0,
    completed bigint DEFAULT 0,
    lovescore bigint DEFAULT 0 NOT NULL,
    guildrank character varying(20) DEFAULT 'Member'::character varying,
    backgrounds text[],
    puzzles bigint DEFAULT 0,
    atkmultiply numeric DEFAULT 1.0,
    defmultiply numeric DEFAULT 1.0,
    trickortreat bigint DEFAULT 0,
    eastereggs bigint DEFAULT 0
);


ALTER TABLE public.profile OWNER TO jens;

--
-- Name: server; Type: TABLE; Schema: public; Owner: jens
--

CREATE TABLE public.server (
    id bigint,
    prefix character varying(10),
    unknown boolean
);


ALTER TABLE public.server OWNER TO jens;

--
-- Name: allitems id; Type: DEFAULT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.allitems ALTER COLUMN id SET DEFAULT nextval('public.allitems_id_seq'::regclass);


--
-- Name: guild id; Type: DEFAULT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.guild ALTER COLUMN id SET DEFAULT nextval('public.guild_id_seq'::regclass);


--
-- Name: inventory id; Type: DEFAULT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.inventory ALTER COLUMN id SET DEFAULT nextval('public.inventory_id_seq'::regclass);


--
-- Name: market id; Type: DEFAULT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.market ALTER COLUMN id SET DEFAULT nextval('public.market_id_seq'::regclass);


--
-- Name: allitems allitems_pkey; Type: CONSTRAINT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.allitems
    ADD CONSTRAINT allitems_pkey PRIMARY KEY (id);


--
-- Name: guild guild_pkey; Type: CONSTRAINT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.guild
    ADD CONSTRAINT guild_pkey PRIMARY KEY (id);


--
-- Name: helpme helpme_pkey; Type: CONSTRAINT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.helpme
    ADD CONSTRAINT helpme_pkey PRIMARY KEY (id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);


--
-- Name: market market_pkey; Type: CONSTRAINT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.market
    ADD CONSTRAINT market_pkey PRIMARY KEY (id);


--
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY ("user");


--
-- Name: allitems allitems_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.allitems
    ADD CONSTRAINT allitems_owner_fkey FOREIGN KEY (owner) REFERENCES public.profile("user") ON DELETE CASCADE;


--
-- Name: guild guild_leader_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.guild
    ADD CONSTRAINT guild_leader_fkey FOREIGN KEY (leader) REFERENCES public.profile("user");


--
-- Name: inventory inventory_item_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_item_fkey FOREIGN KEY (item) REFERENCES public.allitems(id) ON DELETE CASCADE;


--
-- Name: market market_item_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jens
--

ALTER TABLE ONLY public.market
    ADD CONSTRAINT market_item_fkey FOREIGN KEY (item) REFERENCES public.allitems(id) ON DELETE CASCADE;


--
-- Name: TABLE profile; Type: ACL; Schema: public; Owner: jens
--

GRANT ALL ON TABLE public.profile TO votehandler;


--
-- PostgreSQL database dump complete
--


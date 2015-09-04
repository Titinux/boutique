--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: administrators; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE administrators (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    failed_attempts integer DEFAULT 0,
    locked_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: administrators_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE administrators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: administrators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE administrators_id_seq OWNED BY administrators.id;


--
-- Name: assets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE assets (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    category_id integer NOT NULL,
    "pictureUri" character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE assets_id_seq OWNED BY assets.id;


--
-- Name: cart_lines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cart_lines (
    id integer NOT NULL,
    cart_id integer NOT NULL,
    asset_id integer NOT NULL,
    quantity integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: cart_lines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cart_lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cart_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cart_lines_id_seq OWNED BY cart_lines.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE carts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE carts_id_seq OWNED BY carts.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    "pictureUri" character varying(255),
    parent_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: config_tree; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE config_tree (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    form_kind character varying(255),
    type character varying(255),
    parent_id integer,
    lft integer NOT NULL,
    rgt integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: config_tree_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE config_tree_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: config_tree_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE config_tree_id_seq OWNED BY config_tree.id;


--
-- Name: config_values; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE config_values (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    config_tree_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: config_values_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE config_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: config_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE config_values_id_seq OWNED BY config_values.id;


--
-- Name: deposits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE deposits (
    id integer NOT NULL,
    user_id integer,
    asset_id integer,
    quantity integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    validated boolean DEFAULT false NOT NULL
);


--
-- Name: deposits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE deposits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deposits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE deposits_id_seq OWNED BY deposits.id;


--
-- Name: guilds; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE guilds (
    id integer NOT NULL,
    name character varying(255),
    "pictureUri" character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: guilds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE guilds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: guilds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE guilds_id_seq OWNED BY guilds.id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE logs (
    id integer NOT NULL,
    level integer DEFAULT 0 NOT NULL,
    "user" character varying(255) NOT NULL,
    action character varying(255) NOT NULL,
    "objectType" character varying(255) NOT NULL,
    "objectId" integer NOT NULL,
    data text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE logs_id_seq OWNED BY logs.id;


--
-- Name: order_lines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE order_lines (
    id integer NOT NULL,
    order_id integer NOT NULL,
    asset_id integer NOT NULL,
    quantity integer NOT NULL,
    "unitaryPrice" numeric(10,2),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: order_lines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE order_lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE order_lines_id_seq OWNED BY order_lines.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE orders (
    id integer NOT NULL,
    user_id integer NOT NULL,
    state character varying(30) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    dispatched boolean DEFAULT false NOT NULL,
    comment text
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sessions (
    id integer NOT NULL,
    session_id character varying(255) NOT NULL,
    data text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sessions_id_seq OWNED BY sessions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    "pigMoneyBox" integer DEFAULT 0 NOT NULL,
    guild_id integer,
    password_salt character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(128) DEFAULT ''::character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    email character varying(50) DEFAULT ''::character varying NOT NULL,
    gatherer boolean DEFAULT false NOT NULL,
    "dofusNicknames" character varying(255),
    confirmation_token character varying(255),
    reset_password_token character varying(255),
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_at timestamp without time zone,
    last_sign_in_ip character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    failed_attempts integer DEFAULT 0 NOT NULL,
    locked_at timestamp without time zone,
    reset_password_sent_at timestamp without time zone,
    unconfirmed_email character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY administrators ALTER COLUMN id SET DEFAULT nextval('administrators_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY assets ALTER COLUMN id SET DEFAULT nextval('assets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cart_lines ALTER COLUMN id SET DEFAULT nextval('cart_lines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY carts ALTER COLUMN id SET DEFAULT nextval('carts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY config_tree ALTER COLUMN id SET DEFAULT nextval('config_tree_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY config_values ALTER COLUMN id SET DEFAULT nextval('config_values_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY deposits ALTER COLUMN id SET DEFAULT nextval('deposits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY guilds ALTER COLUMN id SET DEFAULT nextval('guilds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY logs ALTER COLUMN id SET DEFAULT nextval('logs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY order_lines ALTER COLUMN id SET DEFAULT nextval('order_lines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sessions ALTER COLUMN id SET DEFAULT nextval('sessions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: administrators_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY administrators
    ADD CONSTRAINT administrators_pkey PRIMARY KEY (id);


--
-- Name: assets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: cart_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cart_lines
    ADD CONSTRAINT cart_lines_pkey PRIMARY KEY (id);


--
-- Name: carts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: config_tree_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY config_tree
    ADD CONSTRAINT config_tree_pkey PRIMARY KEY (id);


--
-- Name: config_values_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY config_values
    ADD CONSTRAINT config_values_pkey PRIMARY KEY (id);


--
-- Name: deposits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY deposits
    ADD CONSTRAINT deposits_pkey PRIMARY KEY (id);


--
-- Name: guilds_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY guilds
    ADD CONSTRAINT guilds_pkey PRIMARY KEY (id);


--
-- Name: logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: order_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY order_lines
    ADD CONSTRAINT order_lines_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_administrators_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_administrators_on_email ON administrators USING btree (email);


--
-- Name: index_administrators_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_administrators_on_name ON administrators USING btree (name);


--
-- Name: index_deposits_on_user_id_and_asset_id_and_validated; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_deposits_on_user_id_and_asset_id_and_validated ON deposits USING btree (user_id, asset_id, validated);


--
-- Name: index_sessions_on_session_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sessions_on_session_id ON sessions USING btree (session_id);


--
-- Name: index_sessions_on_updated_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sessions_on_updated_at ON sessions USING btree (updated_at);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_name ON users USING btree (name);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20081214181537');

INSERT INTO schema_migrations (version) VALUES ('20081214215348');

INSERT INTO schema_migrations (version) VALUES ('20081214231817');

INSERT INTO schema_migrations (version) VALUES ('20081214232124');

INSERT INTO schema_migrations (version) VALUES ('20081214234903');

INSERT INTO schema_migrations (version) VALUES ('20081214235200');

INSERT INTO schema_migrations (version) VALUES ('20081215002523');

INSERT INTO schema_migrations (version) VALUES ('20081228102906');

INSERT INTO schema_migrations (version) VALUES ('20081228161753');

INSERT INTO schema_migrations (version) VALUES ('20081231133941');

INSERT INTO schema_migrations (version) VALUES ('20090214174432');

INSERT INTO schema_migrations (version) VALUES ('20090216003414');

INSERT INTO schema_migrations (version) VALUES ('20090410223700');

INSERT INTO schema_migrations (version) VALUES ('20090412111924');

INSERT INTO schema_migrations (version) VALUES ('20090415191236');

INSERT INTO schema_migrations (version) VALUES ('20090514151944');

INSERT INTO schema_migrations (version) VALUES ('20090514200743');

INSERT INTO schema_migrations (version) VALUES ('20090615211505');

INSERT INTO schema_migrations (version) VALUES ('20090927090204');

INSERT INTO schema_migrations (version) VALUES ('20091202143243');

INSERT INTO schema_migrations (version) VALUES ('20091217134809');

INSERT INTO schema_migrations (version) VALUES ('20100102184909');

INSERT INTO schema_migrations (version) VALUES ('20100609111710');

INSERT INTO schema_migrations (version) VALUES ('20100622140757');

INSERT INTO schema_migrations (version) VALUES ('20100707180314');

INSERT INTO schema_migrations (version) VALUES ('20100906184854');

INSERT INTO schema_migrations (version) VALUES ('20100906191051');

INSERT INTO schema_migrations (version) VALUES ('20110709130341');

INSERT INTO schema_migrations (version) VALUES ('20110726113011');

INSERT INTO schema_migrations (version) VALUES ('20110726113037');

INSERT INTO schema_migrations (version) VALUES ('20120120181756');

INSERT INTO schema_migrations (version) VALUES ('20120120191039');

INSERT INTO schema_migrations (version) VALUES ('20120521231835');

INSERT INTO schema_migrations (version) VALUES ('20130618122455');

INSERT INTO schema_migrations (version) VALUES ('20130621152316');

--
-- PostgreSQL database dump
--

\restrict Nz1lQ9yPfT31k2CWeQxIwjfHrhdxCZhYw2nVZr5bK8XhEKhmcPFxOt6YTjbwmAn

-- Dumped from database version 18.0 (Ubuntu 18.0-1.pgdg25.10+3)
-- Dumped by pg_dump version 18.0 (Ubuntu 18.0-1.pgdg25.10+3)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: booking_seats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking_seats (
    id bigint NOT NULL,
    booking_id bigint,
    seat_id bigint,
    status text DEFAULT 'reserved'::text,
    created_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.booking_seats OWNER TO postgres;

--
-- Name: booking_seats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.booking_seats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_seats_id_seq OWNER TO postgres;

--
-- Name: booking_seats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.booking_seats_id_seq OWNED BY public.booking_seats.id;


--
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    id bigint NOT NULL,
    user_id bigint,
    schedule_id bigint,
    booking_code text NOT NULL,
    status text DEFAULT 'pending'::text,
    total_price numeric(10,2),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bookings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_id_seq OWNER TO postgres;

--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: cinemas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cinemas (
    id bigint NOT NULL,
    city_id bigint,
    name text NOT NULL,
    address text
);


ALTER TABLE public.cinemas OWNER TO postgres;

--
-- Name: cinemas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cinemas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cinemas_id_seq OWNER TO postgres;

--
-- Name: cinemas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cinemas_id_seq OWNED BY public.cinemas.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_id_seq OWNER TO postgres;

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    id bigint NOT NULL,
    title text NOT NULL,
    duration text,
    genre text,
    description text,
    created_at timestamp with time zone
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- Name: movies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movies_id_seq OWNER TO postgres;

--
-- Name: movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movies_id_seq OWNED BY public.movies.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id bigint NOT NULL,
    booking_id bigint,
    amount numeric(10,2) NOT NULL,
    payment_method text,
    status text DEFAULT 'pending'::text,
    payment_code text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedules (
    id bigint NOT NULL,
    movie_id bigint,
    studio_id bigint,
    show_time timestamp with time zone,
    price numeric(10,2),
    created_at timestamp with time zone
);


ALTER TABLE public.schedules OWNER TO postgres;

--
-- Name: schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schedules_id_seq OWNER TO postgres;

--
-- Name: schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedules_id_seq OWNED BY public.schedules.id;


--
-- Name: seats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seats (
    id bigint NOT NULL,
    studio_id bigint,
    row_number text NOT NULL,
    seat_number bigint NOT NULL,
    seat_type text DEFAULT 'regular'::text,
    created_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.seats OWNER TO postgres;

--
-- Name: seats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seats_id_seq OWNER TO postgres;

--
-- Name: seats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seats_id_seq OWNED BY public.seats.id;


--
-- Name: studios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.studios (
    id bigint NOT NULL,
    cinema_id bigint,
    name text NOT NULL,
    capacity bigint NOT NULL,
    created_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.studios OWNER TO postgres;

--
-- Name: studios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.studios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.studios_id_seq OWNER TO postgres;

--
-- Name: studios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.studios_id_seq OWNED BY public.studios.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    name text NOT NULL,
    role text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: booking_seats id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_seats ALTER COLUMN id SET DEFAULT nextval('public.booking_seats_id_seq'::regclass);


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: cinemas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cinemas ALTER COLUMN id SET DEFAULT nextval('public.cinemas_id_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: movies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: schedules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules ALTER COLUMN id SET DEFAULT nextval('public.schedules_id_seq'::regclass);


--
-- Name: seats id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seats ALTER COLUMN id SET DEFAULT nextval('public.seats_id_seq'::regclass);


--
-- Name: studios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studios ALTER COLUMN id SET DEFAULT nextval('public.studios_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: booking_seats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking_seats (id, booking_id, seat_id, status, created_at, deleted_at) FROM stdin;
1	1	1	reserved	2025-10-21 16:12:21.620989+07	\N
2	1	2	reserved	2025-10-21 16:12:21.623881+07	\N
3	1	3	reserved	2025-10-21 16:12:21.625374+07	\N
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (id, user_id, schedule_id, booking_code, status, total_price, created_at, updated_at, deleted_at) FROM stdin;
1	1	1	ZQBBA0CR	pending	150000.00	2025-10-21 16:12:21.617903+07	2025-10-21 16:12:21.617903+07	\N
\.


--
-- Data for Name: cinemas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cinemas (id, city_id, name, address) FROM stdin;
1	1	Grand Indonesia	Jl. M.H. Thamrin No.1
2	1	Plaza Senayan	Jl. Asia Afrika No.8
3	2	Paris Van Java	Jl. Sukajadi No.1
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cities (id, name) FROM stdin;
1	Jakarta
2	Bandung
3	Surabaya
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies (id, title, duration, genre, description, created_at) FROM stdin;
1	Avengers: Endgame	181	Action	The epic conclusion to the Infinity Saga	\N
2	The Lion King	118	Animation	Live action remake of the classic	\N
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, booking_id, amount, payment_method, status, payment_code, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedules (id, movie_id, studio_id, show_time, price, created_at) FROM stdin;
1	1	1	2024-01-20 19:00:00+07	50000.00	\N
2	1	1	2024-01-20 22:00:00+07	55000.00	\N
3	2	2	2024-01-20 15:00:00+07	45000.00	\N
\.


--
-- Data for Name: seats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seats (id, studio_id, row_number, seat_number, seat_type, created_at, deleted_at) FROM stdin;
1	1	A	1	regular	\N	\N
2	1	A	2	regular	\N	\N
3	1	A	3	regular	\N	\N
4	1	A	4	regular	\N	\N
5	1	A	5	regular	\N	\N
6	1	A	6	regular	\N	\N
7	1	A	7	regular	\N	\N
8	1	A	8	regular	\N	\N
9	1	A	9	regular	\N	\N
10	1	A	10	regular	\N	\N
11	1	A	1	regular	\N	\N
12	1	A	2	regular	\N	\N
13	1	A	3	regular	\N	\N
14	1	A	4	regular	\N	\N
15	1	A	5	regular	\N	\N
16	1	A	6	regular	\N	\N
17	1	A	7	regular	\N	\N
18	1	A	8	regular	\N	\N
19	1	A	9	regular	\N	\N
20	1	A	10	regular	\N	\N
21	1	A	1	regular	\N	\N
22	1	A	2	regular	\N	\N
23	1	A	3	regular	\N	\N
24	1	A	4	regular	\N	\N
25	1	A	5	regular	\N	\N
26	1	A	6	regular	\N	\N
27	1	A	7	regular	\N	\N
28	1	A	8	regular	\N	\N
29	1	A	9	regular	\N	\N
30	1	A	10	regular	\N	\N
31	1	A	1	regular	\N	\N
32	1	A	2	regular	\N	\N
33	1	A	3	regular	\N	\N
34	1	A	4	regular	\N	\N
35	1	A	5	regular	\N	\N
36	1	A	6	regular	\N	\N
37	1	A	7	regular	\N	\N
38	1	A	8	regular	\N	\N
39	1	A	9	regular	\N	\N
40	1	A	10	regular	\N	\N
41	1	A	1	regular	\N	\N
42	1	A	2	regular	\N	\N
43	1	A	3	regular	\N	\N
44	1	A	4	regular	\N	\N
45	1	A	5	regular	\N	\N
46	1	A	6	regular	\N	\N
47	1	A	7	regular	\N	\N
48	1	A	8	regular	\N	\N
49	1	A	9	regular	\N	\N
50	1	A	10	regular	\N	\N
51	1	A	1	regular	\N	\N
52	1	A	2	regular	\N	\N
53	1	A	3	regular	\N	\N
54	1	A	4	regular	\N	\N
55	1	A	5	regular	\N	\N
56	1	A	6	regular	\N	\N
57	1	A	7	regular	\N	\N
58	1	A	8	regular	\N	\N
59	1	A	9	regular	\N	\N
60	1	A	10	regular	\N	\N
61	1	A	1	regular	\N	\N
62	1	A	2	regular	\N	\N
63	1	A	3	regular	\N	\N
64	1	A	4	regular	\N	\N
65	1	A	5	regular	\N	\N
66	1	A	6	regular	\N	\N
67	1	A	7	regular	\N	\N
68	1	A	8	regular	\N	\N
69	1	A	9	regular	\N	\N
70	1	A	10	regular	\N	\N
71	1	A	1	regular	\N	\N
72	1	A	2	regular	\N	\N
73	1	A	3	regular	\N	\N
74	1	A	4	regular	\N	\N
75	1	A	5	regular	\N	\N
76	1	A	6	regular	\N	\N
77	1	A	7	regular	\N	\N
78	1	A	8	regular	\N	\N
79	1	A	9	regular	\N	\N
80	1	A	10	regular	\N	\N
81	1	A	1	regular	\N	\N
82	1	A	2	regular	\N	\N
83	1	A	3	regular	\N	\N
84	1	A	4	regular	\N	\N
85	1	A	5	regular	\N	\N
86	1	A	6	regular	\N	\N
87	1	A	7	regular	\N	\N
88	1	A	8	regular	\N	\N
89	1	A	9	regular	\N	\N
90	1	A	10	regular	\N	\N
91	1	A	1	regular	\N	\N
92	1	A	2	regular	\N	\N
93	1	A	3	regular	\N	\N
94	1	A	4	regular	\N	\N
95	1	A	5	regular	\N	\N
96	1	A	6	regular	\N	\N
97	1	A	7	regular	\N	\N
98	1	A	8	regular	\N	\N
99	1	A	9	regular	\N	\N
100	1	A	10	regular	\N	\N
101	1	B	1	regular	\N	\N
102	1	B	2	regular	\N	\N
103	1	B	3	regular	\N	\N
104	1	B	4	regular	\N	\N
105	1	B	5	regular	\N	\N
106	1	B	6	regular	\N	\N
107	1	B	7	regular	\N	\N
108	1	B	8	regular	\N	\N
109	1	B	9	regular	\N	\N
110	1	B	10	regular	\N	\N
111	1	B	1	regular	\N	\N
112	1	B	2	regular	\N	\N
113	1	B	3	regular	\N	\N
114	1	B	4	regular	\N	\N
115	1	B	5	regular	\N	\N
116	1	B	6	regular	\N	\N
117	1	B	7	regular	\N	\N
118	1	B	8	regular	\N	\N
119	1	B	9	regular	\N	\N
120	1	B	10	regular	\N	\N
121	1	B	1	regular	\N	\N
122	1	B	2	regular	\N	\N
123	1	B	3	regular	\N	\N
124	1	B	4	regular	\N	\N
125	1	B	5	regular	\N	\N
126	1	B	6	regular	\N	\N
127	1	B	7	regular	\N	\N
128	1	B	8	regular	\N	\N
129	1	B	9	regular	\N	\N
130	1	B	10	regular	\N	\N
131	1	B	1	regular	\N	\N
132	1	B	2	regular	\N	\N
133	1	B	3	regular	\N	\N
134	1	B	4	regular	\N	\N
135	1	B	5	regular	\N	\N
136	1	B	6	regular	\N	\N
137	1	B	7	regular	\N	\N
138	1	B	8	regular	\N	\N
139	1	B	9	regular	\N	\N
140	1	B	10	regular	\N	\N
141	1	B	1	regular	\N	\N
142	1	B	2	regular	\N	\N
143	1	B	3	regular	\N	\N
144	1	B	4	regular	\N	\N
145	1	B	5	regular	\N	\N
146	1	B	6	regular	\N	\N
147	1	B	7	regular	\N	\N
148	1	B	8	regular	\N	\N
149	1	B	9	regular	\N	\N
150	1	B	10	regular	\N	\N
151	1	B	1	regular	\N	\N
152	1	B	2	regular	\N	\N
153	1	B	3	regular	\N	\N
154	1	B	4	regular	\N	\N
155	1	B	5	regular	\N	\N
156	1	B	6	regular	\N	\N
157	1	B	7	regular	\N	\N
158	1	B	8	regular	\N	\N
159	1	B	9	regular	\N	\N
160	1	B	10	regular	\N	\N
161	1	B	1	regular	\N	\N
162	1	B	2	regular	\N	\N
163	1	B	3	regular	\N	\N
164	1	B	4	regular	\N	\N
165	1	B	5	regular	\N	\N
166	1	B	6	regular	\N	\N
167	1	B	7	regular	\N	\N
168	1	B	8	regular	\N	\N
169	1	B	9	regular	\N	\N
170	1	B	10	regular	\N	\N
171	1	B	1	regular	\N	\N
172	1	B	2	regular	\N	\N
173	1	B	3	regular	\N	\N
174	1	B	4	regular	\N	\N
175	1	B	5	regular	\N	\N
176	1	B	6	regular	\N	\N
177	1	B	7	regular	\N	\N
178	1	B	8	regular	\N	\N
179	1	B	9	regular	\N	\N
180	1	B	10	regular	\N	\N
181	1	B	1	regular	\N	\N
182	1	B	2	regular	\N	\N
183	1	B	3	regular	\N	\N
184	1	B	4	regular	\N	\N
185	1	B	5	regular	\N	\N
186	1	B	6	regular	\N	\N
187	1	B	7	regular	\N	\N
188	1	B	8	regular	\N	\N
189	1	B	9	regular	\N	\N
190	1	B	10	regular	\N	\N
191	1	B	1	regular	\N	\N
192	1	B	2	regular	\N	\N
193	1	B	3	regular	\N	\N
194	1	B	4	regular	\N	\N
195	1	B	5	regular	\N	\N
196	1	B	6	regular	\N	\N
197	1	B	7	regular	\N	\N
198	1	B	8	regular	\N	\N
199	1	B	9	regular	\N	\N
200	1	B	10	regular	\N	\N
\.


--
-- Data for Name: studios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.studios (id, cinema_id, name, capacity, created_at, deleted_at) FROM stdin;
1	1	Studio 1	100	\N	\N
2	1	Studio 2	80	\N	\N
3	2	Studio A	120	\N	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, name, role, created_at, updated_at, deleted_at) FROM stdin;
1	admin@cinema.com	$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi	Admin	admin	\N	\N	\N
2	customer@example.com	$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi	John Doe	customer	\N	\N	\N
4	cobauser1@example.com	$2a$10$L5h6reTGHKPOOeYkhw6QLe.cMcV66hdc1Ri7lI4w5hg2WYX6yNy/a	Coba 1 User	customer	2025-10-21 16:31:08.817706+07	2025-10-21 16:31:08.817706+07	\N
\.


--
-- Name: booking_seats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.booking_seats_id_seq', 3, true);


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bookings_id_seq', 1, true);


--
-- Name: cinemas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cinemas_id_seq', 3, true);


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_id_seq', 3, true);


--
-- Name: movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_id_seq', 2, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_id_seq', 1, false);


--
-- Name: schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedules_id_seq', 4, true);


--
-- Name: seats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seats_id_seq', 200, true);


--
-- Name: studios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.studios_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- Name: booking_seats booking_seats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_seats
    ADD CONSTRAINT booking_seats_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: cinemas cinemas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cinemas
    ADD CONSTRAINT cinemas_pkey PRIMARY KEY (id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (id);


--
-- Name: seats seats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_pkey PRIMARY KEY (id);


--
-- Name: studios studios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studios
    ADD CONSTRAINT studios_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_booking_seats_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_seats_deleted_at ON public.booking_seats USING btree (deleted_at);


--
-- Name: idx_bookings_booking_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_bookings_booking_code ON public.bookings USING btree (booking_code);


--
-- Name: idx_bookings_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_deleted_at ON public.bookings USING btree (deleted_at);


--
-- Name: idx_payments_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payments_deleted_at ON public.payments USING btree (deleted_at);


--
-- Name: idx_payments_payment_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_payments_payment_code ON public.payments USING btree (payment_code);


--
-- Name: idx_seats_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_seats_deleted_at ON public.seats USING btree (deleted_at);


--
-- Name: idx_studios_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_studios_deleted_at ON public.studios USING btree (deleted_at);


--
-- Name: idx_users_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_deleted_at ON public.users USING btree (deleted_at);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: booking_seats fk_booking_seats_seat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_seats
    ADD CONSTRAINT fk_booking_seats_seat FOREIGN KEY (seat_id) REFERENCES public.seats(id);


--
-- Name: booking_seats fk_bookings_booking_seats; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_seats
    ADD CONSTRAINT fk_bookings_booking_seats FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


--
-- Name: payments fk_bookings_payments; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_bookings_payments FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


--
-- Name: bookings fk_bookings_schedule; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_bookings_schedule FOREIGN KEY (schedule_id) REFERENCES public.schedules(id);


--
-- Name: bookings fk_bookings_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_bookings_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: cinemas fk_cinemas_city; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cinemas
    ADD CONSTRAINT fk_cinemas_city FOREIGN KEY (city_id) REFERENCES public.cities(id);


--
-- Name: schedules fk_schedules_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT fk_schedules_movie FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- Name: schedules fk_schedules_studio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT fk_schedules_studio FOREIGN KEY (studio_id) REFERENCES public.studios(id);


--
-- Name: studios fk_studios_cinema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studios
    ADD CONSTRAINT fk_studios_cinema FOREIGN KEY (cinema_id) REFERENCES public.cinemas(id);


--
-- Name: seats fk_studios_seats; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seats
    ADD CONSTRAINT fk_studios_seats FOREIGN KEY (studio_id) REFERENCES public.studios(id);


--
-- PostgreSQL database dump complete
--

\unrestrict Nz1lQ9yPfT31k2CWeQxIwjfHrhdxCZhYw2nVZr5bK8XhEKhmcPFxOt6YTjbwmAn


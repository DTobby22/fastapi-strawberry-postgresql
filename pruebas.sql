PGDMP                     
    z            prueba    15.0    15.0                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16398    prueba    DATABASE     y   CREATE DATABASE prueba WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE prueba;
                postgres    false            ?            1259    16409    comments    TABLE     ?   CREATE TABLE public.comments (
    id integer NOT NULL,
    description character varying(250),
    created_at date,
    post_id integer
);
    DROP TABLE public.comments;
       public         heap    postgres    false            ?            1259    16404    posts    TABLE     ?   CREATE TABLE public.posts (
    id integer NOT NULL,
    description character varying(500),
    video_url text,
    created_at date
);
    DROP TABLE public.posts;
       public         heap    postgres    false            ?          0    16409    comments 
   TABLE DATA           H   COPY public.comments (id, description, created_at, post_id) FROM stdin;
    public          postgres    false    215          ?          0    16404    posts 
   TABLE DATA           G   COPY public.posts (id, description, video_url, created_at) FROM stdin;
    public          postgres    false    214   z       k           2606    16461    comments pk_id_comments 
   CONSTRAINT     U   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT pk_id_comments PRIMARY KEY (id);
 A   ALTER TABLE ONLY public.comments DROP CONSTRAINT pk_id_comments;
       public            postgres    false    215            i           2606    16441    posts pk_id_post 
   CONSTRAINT     N   ALTER TABLE ONLY public.posts
    ADD CONSTRAINT pk_id_post PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.posts DROP CONSTRAINT pk_id_post;
       public            postgres    false    214            m           2606    16482    comments uk_post_id 
   CONSTRAINT     Q   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT uk_post_id UNIQUE (post_id);
 =   ALTER TABLE ONLY public.comments DROP CONSTRAINT uk_post_id;
       public            postgres    false    215            n           2606    16470    comments fk_post_id    FK CONSTRAINT     |   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_post_id FOREIGN KEY (post_id) REFERENCES public.posts(id) NOT VALID;
 =   ALTER TABLE ONLY public.comments DROP CONSTRAINT fk_post_id;
       public          postgres    false    214    3177    215            ?   [   x?3?t?(??LN?K?Wp??4202?54?5??4?2B?,J,?(?AVa?e̙??
20?50?4?24⬨? ?? ?M9͹Lх,?b???? ?w?      ?   ?   x?????0??????nO#"??TBP?e?ʃ??͆??-??Sяw?>?0?%??*3?"?\8???'????e=??ڝ:d\???"?8!y?U???@щ"K?n?{ư??^:a~0?eγ?m5쓗32??ë?/ S??8??H??C????;c??$????cH???e4     
PGDMP         7                w            webshop     10.8 (Ubuntu 10.8-1.pgdg18.04+1)     11.3 (Ubuntu 11.3-1.pgdg18.04+1) !    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    33402    webshop    DATABASE     y   CREATE DATABASE webshop WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE webshop;
             postgres    false            �            1255    41614    tg_bf_insert_orders()    FUNCTION     v  CREATE FUNCTION public.tg_bf_insert_orders() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
	avail integer := (select available from inventory where product_id = new.product_id);
begin
	if(avail >= new.quantity) then 
		update inventory
		set available = avail - new.quantity
		where product_id = new.product_id;
		return new;
	else
		return null;
	end if;
end; $$;
 ,   DROP FUNCTION public.tg_bf_insert_orders();
       public       postgres    false            �            1259    33427 
   categories    TABLE     s   CREATE TABLE public.categories (
    category integer NOT NULL,
    categoryname character varying(50) NOT NULL
);
    DROP TABLE public.categories;
       public         postgres    false            �            1259    33425    categories_category_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_category_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.categories_category_seq;
       public       postgres    false    200            �           0    0    categories_category_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.categories_category_seq OWNED BY public.categories.category;
            public       postgres    false    199            �            1259    33422 	   inventory    TABLE        CREATE TABLE public.inventory (
    product_id integer NOT NULL,
    available integer NOT NULL,
    sales integer NOT NULL
);
    DROP TABLE public.inventory;
       public         postgres    false            �            1259    33433    orders    TABLE     �   CREATE TABLE public.orders (
    order_id integer NOT NULL,
    orderdate date NOT NULL,
    customer_id integer,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    total_cost numeric(12,2) NOT NULL
);
    DROP TABLE public.orders;
       public         postgres    false            �            1259    33431    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.orders_order_id_seq;
       public       postgres    false    202            �           0    0    orders_order_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;
            public       postgres    false    201            �            1259    33439    products    TABLE     �   CREATE TABLE public.products (
    product_id integer NOT NULL,
    category integer NOT NULL,
    title character varying(50) NOT NULL,
    price numeric(12,2) NOT NULL,
    imageurl character varying(200) NOT NULL
);
    DROP TABLE public.products;
       public         postgres    false            �            1259    33437    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.products_product_id_seq;
       public       postgres    false    204            �           0    0    products_product_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;
            public       postgres    false    203            �            1259    33410    users    TABLE     P  CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    role character varying(50) NOT NULL,
    avatar_url character varying(200) DEFAULT 'https://via.placeholder.com/150'::character varying NOT NULL,
    fullname character varying(50)
);
    DROP TABLE public.users;
       public         postgres    false            �            1259    33408    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public       postgres    false    197            �           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
            public       postgres    false    196            �
           2604    33430    categories category    DEFAULT     z   ALTER TABLE ONLY public.categories ALTER COLUMN category SET DEFAULT nextval('public.categories_category_seq'::regclass);
 B   ALTER TABLE public.categories ALTER COLUMN category DROP DEFAULT;
       public       postgres    false    200    199    200            �
           2604    33436    orders order_id    DEFAULT     r   ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);
 >   ALTER TABLE public.orders ALTER COLUMN order_id DROP DEFAULT;
       public       postgres    false    202    201    202            �
           2604    33442    products product_id    DEFAULT     z   ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 B   ALTER TABLE public.products ALTER COLUMN product_id DROP DEFAULT;
       public       postgres    false    203    204    204            �
           2604    33413    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public       postgres    false    196    197    197            ~          0    33427 
   categories 
   TABLE DATA               <   COPY public.categories (category, categoryname) FROM stdin;
    public       postgres    false    200   �$       |          0    33422 	   inventory 
   TABLE DATA               A   COPY public.inventory (product_id, available, sales) FROM stdin;
    public       postgres    false    198   %       �          0    33433    orders 
   TABLE DATA               d   COPY public.orders (order_id, orderdate, customer_id, product_id, quantity, total_cost) FROM stdin;
    public       postgres    false    202   d%       �          0    33439    products 
   TABLE DATA               P   COPY public.products (product_id, category, title, price, imageurl) FROM stdin;
    public       postgres    false    204   �%       {          0    33410    users 
   TABLE DATA               X   COPY public.users (user_id, username, password, role, avatar_url, fullname) FROM stdin;
    public       postgres    false    197   (       �           0    0    categories_category_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.categories_category_seq', 1, false);
            public       postgres    false    199            �           0    0    orders_order_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);
            public       postgres    false    201            �           0    0    products_product_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.products_product_id_seq', 1, false);
            public       postgres    false    203            �           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 16, true);
            public       postgres    false    196            �
           2606    33415    users users_pk 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (user_id);
 8   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pk;
       public         postgres    false    197                        2620    41615    orders bf_insert_orders    TRIGGER     �   CREATE TRIGGER bf_insert_orders BEFORE INSERT ON public.orders FOR EACH ROW WHEN ((new.order_id IS NOT NULL)) EXECUTE PROCEDURE public.tg_bf_insert_orders();
 0   DROP TRIGGER bf_insert_orders ON public.orders;
       public       postgres    false    205    202    202            ~   m   x�5�A�0Dѵ�9j
� ��K66�DT7E��?A����H�ip-%���L1�����Ug�q�r�t��T�,;�=�0���q蛫#�To�6���	�kd%=      |   :   x�=��  ��c�<Pwq�94�5�t�����)=Ұv���Lz�m@j�?�*"��]      �      x������ � �      �   �  x��S]s�0}���?�/ ���c���ڡ�v���01DD�P?�_��n}�YfrÝ�sν�@ݮ\0��&s敪���K�1��T��Y�S�aɑ�9�d��'U"���9c�N����h5A�|�,F�*���������f�V#�;3�d�瀺��d��U��F���e��CW���$;a4f��ש���'q��<����(��h����t��v��纀�E�
g��愈D����z�6R�T��u�a�\�A��!Os	�B��KB�3���+|�rC��4}��Y�.�����l�!��?�a
��*Y��_p��Y�<�K�b�0�e��4ao��Q>9��*��V%���B檔�T��D��3ϥ��f��)U m��,��l��?�8D1uC�)^�|g>��.��`�������x%���ǡ)�-4P������h��]�FY�3�sgʓ:K��άU��d⼜��7��b;I�n����kU}���b-1ev��x,��ņE��Q��Khi�IO�VW*ת��~�ύ�ķf��ߢ����U^����k���ʊ�H[e	7��w<��;�^��B\�j(Z$�$�k�����]-�K=K�0�˥�sg.�C�c
����}ܥ}��rY6>�P����u:��A�O�      {   �   x��н
�0���y��-��t�N.!	����зoԡ���-w?�w	8�P�$��<_���G��M�5���E����f�F܌qR��f�6�pڮ�$�Q�x3��Ό�J��O���<*��ޠ����>$�������!�r��|��4ڮ�
�t�N|K�Z����G,IJ���̭�z��!�E���=��     
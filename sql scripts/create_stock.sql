create table staging(
    trade_date text,
    Ticker text,
    Close text,
    high text,
    low text,
    open text,
    volume text
);

create table raw_data(
    trade_date date,
    Ticker varchar(10),
    Close numeric(8,2),
    high numeric(8,2),
    low numeric(8,2),
    open numeric(8,2),
    volume bigint
);

create table companies(
    Ticker varchar(10) primary key,
    stock_name varchar(100)
);
create table stock_info(
    Ticker varchar(10),
    trade_date date,
    Open numeric(8, 2),
    Close numeric(8, 2),
    High numeric(8, 2),
    Low numeric(8, 2),
    Volume bigint,
    primary key (ticker, trade_date),
    foreign key(ticker) references companies(ticker)
);

create table calendar(
    trade_date date primary key,
    Year       int,
    Quarter    int,
    Month      int,
    Month_name varchar(10),
    day        int
);
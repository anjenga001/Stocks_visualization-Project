INSERT INTO raw_data
SELECT
    trade_date::DATE,
    ticker,
    close::NUMERIC(8,2),
    high::NUMERIC(8,2),
    low::NUMERIC(8,2),
    open::NUMERIC(8,2),
    volume::BIGINT
FROM staging;

insert into companies(Ticker)
select distinct raw_data.ticker from raw_data
where not exists(
    select 1
    from companies
    where companies.Ticker = raw_data.ticker
);

insert into stock_info(ticker, trade_date, Open, Close, High, Low, Volume)
select ticker, trade_date, open, close, high, low, volume
from raw_data
on conflict (ticker, trade_date) do nothing;

insert into calendar
select
    d::date as date,
    extract(year from d) as year,
    extract(quarter from d) as quarter,
    extract(month from d) as month,
    to_char(d, 'month') as  Month_name,
    extract(day from d) as day
from generate_series(
        '2021-01-04'::date,
        '2025-12-31'::date,
        interval '1 day'
     )d;


update companies
set stock_name = case Ticker
    when 'MSFT' then 'Microsoft Corp'
    when 'NET' then 'Cloudfare Inc.'
    when 'NTAP' then 'Netapp Inc.'
    when 'ORCL' then 'ORCL Corp'
    when 'SNPS' then 'Synopsys Inc.'
end
where Ticker in ('MSFT', 'NET', 'NTAP', 'ORCL', 'SNPS');
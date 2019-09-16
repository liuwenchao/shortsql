# shortsql

A collection of scripts to run SQL in a shorter way, like:
```
l users -- equivlant to: select * from users;
```

## Installation

1. Download or clone
1. Change Configuration File or just test with the default

## Mysql Usage

1. `cd mysql`
2. `cp my.cnf .my.cnf`
3. change .my.cnf to your configuration
4. `sh ./g.sh`

## Example
```mysql
l users
; select * from users;
s users name,type id=1
; select name,type from users where id=1; 
c users
; select count(*) from users;
sh users
; show create table users;
g users name
; select name, count(*) from users group by name;
del users id=1
; delete from users where id=1;
```

## Contributing

Scripts are needed for other databases.

1. Fork it!
1. Create your feature branch: `git checkout -b my-new-feature`
1. Commit your changes: `git commit -am 'Add some feature'`
1. Push to the branch: `git push origin my-new-feature`
1. Submit a pull request :D

## TODO
1. history
2. auto-completion
3. more database adaptors

## History

TODO: Write history

## Credits

TODO: Write credits

## License

MIT

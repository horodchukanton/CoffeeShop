DB_NAME=bukinist
DB_USER=bukinist
DB_PASS=bukinist_dev
PROJECT_NAME=CoffeeShop
PROJECT_DIR=/usr/bukinist
PROJECT_LIB_DIR=${PROJECT_DIR}/lib
SHEMA_PACKAGE=CoffeeShop::Schema

db_install:
	mysqladmin create ${DB_NAME} || true
	mysql -e 'GRANT ALL ON ${DB_NAME}.* TO `${DB_USER}`@localhost IDENTIFIED BY "${DB_PASS}";'
	mysql -D ${DB_NAME} -u${DB_USER} -p${DB_PASS} < ${PROJECT_DIR}/db/schema.sql
  
dbicdump:
	dbicdump -Ilib -o dump_directory=${PROJECT_LIB_DIR} -o preserve_case=1 ${SHEMA_PACKAGE} \
   dbi:mysql:database=${DB_NAME} ${DB_USER} "${DB_PASS}"
   
install:
	TOKEN ?= $(shell bash -c 'read -s -p "Telegram token: " pwd; echo $$pwd')
  cp ${PROJECT_DIR}/config.pl.default ${PROJECT_DIR}/config.pl
  sed -i -i 's/%TOKEN%/${TOKEN}/' ${PROJECT_DIR}/config.pl
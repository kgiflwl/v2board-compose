#/*
# * This file is part of kgiflwl/v2board-compose.
# *
# * kgiflwl/v2board-compose is free software: you can redistribute it and/or modify
# * it under the terms of the GNU General Public License as published by
# * the Free Software Foundation, either version 3 of the License, or
# * (at your option) any later version.
# *
# * kgiflwl/v2board-compose is distributed in the hope that it will be useful,
# * but WITHOUT ANY WARRANTY; without even the implied warranty of
# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# * GNU General Public License for more details.
# *
# * You should have received a copy of the GNU General Public License
# * along with kgiflwl/v2board-compose. If not, see <https://www.gnu.org/licenses/>.
# */

#!/bin/bash

cat <<EOF > ./config/docker-entrypoint-initdb.d/init.sql
--/*
-- * This file is part of kgiflwl/v2board-compose.
-- *
-- * kgiflwl/v2board-compose is free software: you can redistribute it and/or modify
-- * it under the terms of the GNU General Public License as published by
-- * the Free Software Foundation, either version 3 of the License, or
-- * (at your option) any later version.
-- *
-- * kgiflwl/v2board-compose is distributed in the hope that it will be useful,
-- * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- * GNU General Public License for more details.
-- *
-- * You should have received a copy of the GNU General Public License
-- * along with kgiflwl/v2board-compose. If not, see <https://www.gnu.org/licenses/>.
-- */

CREATE DATABASE $DB_DATABASE CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER '$DB_USERNAME'@'%';
GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD';
FLUSH PRIVILEGES;
EOF

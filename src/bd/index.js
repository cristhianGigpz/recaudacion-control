const { Client, Pool } = require("pg");
require("custom-env").env("config");

const connection = new Client({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_BASEDATOS,
  password: process.env.DB_PASS,
  port: process.env.DB_PORT
});

async function loadGetData(table) {
    // const connet = this.connection();
    connection.connect(err => {
      if (err) return err;
    });
    const listData = connection
      .query(`SELECT * FROM ${table} WHERE estado = $1`, [1])
      .then(res => {
        const loadData = res.rows.length > 0 ? res.rows : [];
        return loadData;
      })
      .catch(e => console.log(e));

    return await listData;
  }

  async function loadGetDataId(table, field, value) {
    connection.connect(err => {
      if (err) return err;
    });
    const sqlData = connection
      .query(`SELECT * FROM ${table} where ${field} = $1`, [value])
      .then(res => {
        const loadData = res.rows.length > 0 ? res.rows : [];
        return loadData;
      })
      .catch(e => console.log(e));

    return await sqlData;
  }

  async function executeQuery(query, params, table) {
    const data = connection
      .query(query, params)
      .then(res => {
        return loadGetData(table);
      })
      .catch(e => console.log(`${new Date()} :error ==>${e}`));
    return await data;
  }
  
  function createInsertQuery(tablename, obj) {
    let insert = `INSERT INTO ${tablename}`;
    let keys = Object.keys(obj);
    let dollar = keys.map(function(item, idx) {
      return "$" + (idx + 1);
    });
    let values = Object.keys(obj).map(function(k) {
      return obj[k];
    });
    return {
      query: `${insert} (${keys}) VALUES (${dollar})`,
      params: values
    };
  }

  function createUpdateQuery(tablename, obj, fields, fieldsValue) {
    let update = [`UPDATE ${tablename}`];
    update.push("SET");
    let set = [];
    Object.keys(obj).forEach(function(key, i) {
      set.push(key + " = ($" + (i + 1) + ")");
    });
    let values = Object.keys(obj).map(function(k) {
      return obj[k];
    });
    update.push(set.join(", "));
    update.push(`WHERE ${fields} = ${fieldsValue}`);
    return {
      query: update.join(" "),
      params: values
    };
  }

  module.exports = {
      loadGetData,
      loadGetDataId,
      executeQuery,
      createInsertQuery,
      createUpdateQuery
  }
  
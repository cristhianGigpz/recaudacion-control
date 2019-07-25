import { remote, ipcRenderer } from 'electron';

import { openWindow } from './ipcRendererEvents';
const { Client, Pool } = require('pg');
require('custom-env').env('config');

const connection =  new Client({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database:  process.env.DB_BASEDATOS,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT
});

class UI{
    /**
     * función para listar los datos de las tablas
     * @param {nombre table} table 
     */
    async loadGetData(table){
       // const connet = this.connection();
        connection.connect((err)=>{
            if(err) return err;
        });
        const listData = connection.query(`SELECT * FROM ${table} WHERE flat = $1`,[1])
        .then((res) =>{
            const loadData = res.rows.length > 0 ? res.rows : [];
            return  loadData;
        })
        .catch(e => console.log(e));

        return await listData;
    }
    async loadGetDataId(table,field,value){
        connection.connect((err)=>{
            if(err) return err;
        });
        const sqlData = connection.query(`SELECT * FROM ${table} where ${field} = $1`,[value])
        .then((res)=>{
            const loadData = res.rows.length > 0 ? res.rows : [];
            return  loadData;
        })
        .catch(e => console.log(e));

        return await sqlData;
    }
    async loadDataJoin(){
        const listData = connection.query(`select * from provincia a
        inner join departamento b 
        on a.iddepartamento = b.iddepartamento where a.flat=1;`)
        .then((res) =>{
            const loadData = res.rows.length > 0 ? res.rows : [];
            return  loadData;
        })
        .catch(e => console.log(e));

        return await listData;
    }
    async loadDataJoinDistrito(){
        const listData = connection.query(`select * from distrito a
        inner join provincia b 
        on a.idprovincia = b.idprovincia
        inner join departamento c
        on b.iddepartamento = c.iddepartamento where a.flat=1;`)
        .then((res) =>{
            const loadData = res.rows.length > 0 ? res.rows : [];
            return  loadData;
        })
        .catch(e => console.log(e));

        return await listData;
    }

    async loadDataJoinUbanisacion(){
        const listData = connection.query(`select 
        a.idurb,a.codigo,
        a.nomurbanisacion,a.abreviatura,a.iddistrito,b.nomdistrito from urbanisacion a
        inner join distrito b
        on a.iddistrito = b.iddistrito where a.flat=1;`)
        .then((res) =>{
            const loadData = res.rows.length > 0 ? res.rows : [];
            return  loadData;
        })
        .catch(e => console.log(e));

        return await listData;
    }

    async loadDataJoinContribuyente(){
        const listContribuyente = connection.query(`select b.idurb,b.nomurbanisacion,a.* from contribuyente a
            inner join urbanisacion b 
            on a.idurb = b.idurb
            where a.flat = 1;`)
        .then((resp) =>{
            const loadContrib = resp.rows.length > 0 ? resp.rows : [];
            return  loadContrib;
        })
        .catch(e => console.log(e));
        return await listContribuyente;
    }
    /**
     * función para registrar data a la BD
     * @param {sentencia sql} _query 
     * @param {valores agregar} value 
     * @param {tabla para el reload de data} table 
     */
    async executeQuery(query,params,table){
        const data = connection.query(query,params)
        .then(res =>{
           return this.loadGetData(table)
        })
        .catch(e => console.log(`${new Date()} :error ==>${e}`));
        return await data;
    }
    createInsertQuery (tablename, obj){
        let insert = `insert into ${tablename}`;
        let keys = Object.keys(obj);
        let dollar = keys.map(function (item, idx) { return '$' + (idx + 1); });
        let values = Object.keys(obj).map(function (k) { return obj[k]; });
        return {
            query: `${insert} (${keys}) values (${dollar})`,
            params: values
        }
    }
    createUpdateQuery (tablename, obj,fields,fieldsValue){
        let update = [`UPDATE ${tablename}`];
        update.push('SET');
        let set = [];
        Object.keys(obj).forEach(function (key, i) {
            set.push(key + ' = ($' + (i + 1) + ')'); 
        });
        let values = Object.keys(obj).map(function (k) { return obj[k]; });
        update.push(set.join(', '));
        update.push(`WHERE ${fields} = ${fieldsValue}`);
        return {
            query : update.join(' '),
            params: values
        }
    }

    /**
     * función cierra formulario
     * @param {id button} idBtn 
     */
    closeFrom(idBtn){
        const btn = document.getElementById(idBtn);
        if(btn){
            btn.addEventListener('click',(e)=>{
                const prefsWindow = remote.getCurrentWindow()
                prefsWindow.close()
            })
        }
    }

    /**
     * función abre una ventana llamada desde un boton del formulario
     * @param {id button} element 
     * @param {width} ancho 
     * @param {hight} alto 
     * @param {title from} title 
     * @param {nombre from} file 
     */
    openWindows(element,ancho,alto,title,file){
        const btn =document.getElementById(element);
        if(btn){
            btn.addEventListener('click',(e)=>{
                e.preventDefault();
                openWindow(ancho, alto, title, true, file);
            })
        }
    }
    /**
     * 
     * @param {*} options 
     */
    showDialog(options){
        ipcRenderer.send('showMessageBox', options);
    }

    validateFrom(form){
        let bool = true;
        for(let i=0; i<form.elements.length; i++) {
            let elemento = form.elements[i];
            if(elemento.type != radio && (elemento.value === 0 || elemento.value ==='')){
                bool = false;
            }
            /*if(elemento.type == "checkbox") {
                if(!elemento.checked) {
                    bool = false;
                }
            }*/

            /*if(elemento.type == "radio") {
                if(elemento.checked) {
                    bool = true;
                }
            }*/
        }
        return bool;
    }

    valueElement(inputId){
        
    }
}
export default UI;
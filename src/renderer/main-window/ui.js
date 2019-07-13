import { remote, ipcRenderer } from 'electron';
const PDFDocument = require("pdfkit");
const {Base64Encode} = require('base64-stream');
const fs = require("fs");
import os from 'os';
import path from 'path';

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

    async insertData(_query,value,table){
        const sql ={
            text: _query,
            values:value
        }
        const data = connection.query(sql)
        .then(res =>{
           return this.loadGetData(table)
        })
        .catch(e => console.log(`${new Date()} :error ==>${e}`));
        return await data;
    }
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
            if(elemento.value === 0 || elemento.value ===''){
                bool = false;
            }
            /*if(elemento.type == "checkbox") {
                if(!elemento.checked) {
                    bool = false;
                }
            }*/
            if(elemento.type == "radio") {
                if(elemento.checked) {
                    bool = true;
                }
            }
        }
        return bool;
    }













    pdfPrint(){
        console.log('prinpdf')
        ipcRenderer.send('print-to-pdf');

        
    }
    

    async createInvoice (invoice, paths,iframe) {
        let doc = new PDFDocument({ margin: 50 });
        //const stream = doc.pipe(blobStream());
        this.generateHeader(doc);
        this.generateCustomerInformation(doc, invoice);
        this.generateInvoiceTable(doc, invoice);
        this.generateFooter(doc);
      
        var finalString = ''; // contains the base64 string
        var  stream = doc.pipe(new Base64Encode());
        
        //doc.pipe(fs.createWriteStream(path));
       /* stream.on('finish', function() {
            // iframe.src = stream.toBlobURL('application/pdf');
            // const pdfPath = path.join(os.tmpdir(),stream.toBlobURL('application/pdf'));
            // console.log(pdfPath);
            const pdfPath =stream.toBlobURL('application/pdf')
            ipcRenderer.send('print-to-pdf',pdfPath);
          });*/
        
         // ipcRenderer.send('print-to-pdf',stream);
        doc.end();
        stream.on('data', chunk => finalString += chunk );
        stream.on('end',()=>  ipcRenderer.send('print-to-pdf', finalString))
    }
    generateHeader(doc) {
        doc
          .fillColor("#444444")
          .fontSize(20)
          .text("ACME Inc.", 110, 57)
          .fontSize(10)
          .text("123 Main Street", 200, 65, { align: "right" })
          .text("New York, NY, 10025", 200, 80, { align: "right" })
          .moveDown();
    }
    generateCustomerInformation(doc, invoice) {
        const shipping = invoice.shipping;
      
        doc
          .text(`Invoice Number: ${invoice.invoice_nr}`, 50, 200)
          .text(`Invoice Date: ${new Date()}`, 50, 215)
          .text(`Balance Due: ${invoice.subtotal - invoice.paid}`, 50, 130)
      
          .text(shipping.name, 300, 200)
          .text(shipping.address, 300, 215)
          .text(
            `${shipping.city}, ${shipping.state}, ${shipping.country}`,
            300,
            130
          )
          .moveDown();
    }
    generateInvoiceTable(doc, invoice) {
        let i,
          invoiceTableTop = 330;
      
        for (i = 0; i < invoice.items.length; i++) {
          const item = invoice.items[i];
          const position = invoiceTableTop + (i + 1) * 30;
          this.generateTableRow(
            doc,
            position,
            item.item,
            item.description,
            item.amount / item.quantity,
            item.quantity,
            item.amount
          );
        }
    }
    generateFooter(doc) {
        doc
          .fontSize(10)
          .text(
            "Payment is due within 15 days. Thank you for your business.",
            50,
            780,
            { align: "center", width: 500 }
          );
    }
    generateTableRow(doc, y, c1, c2, c3, c4, c5) {
        doc
          .fontSize(10)
          .text(c1, 50, y)
          .text(c2, 150, y)
          .text(c3, 280, y, { width: 90, align: "right" })
          .text(c4, 370, y, { width: 90, align: "right" })
          .text(c5, 0, y, { align: "right" });
      }
}
export default UI;
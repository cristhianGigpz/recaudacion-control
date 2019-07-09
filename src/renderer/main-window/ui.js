import { remote, ipcRenderer } from 'electron';
const PDFDocument = require("pdfkit");
const fs = require("fs");

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
        const listData = connection.query(`SELECT * FROM ${table}`)
        .then((res) =>{
            const loadData = res.rows.length > 0 ? res.rows : [];
            return  loadData;
        })
        .catch(e => console.log(e));

        return await listData;
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

    pdfPrint(){
        console.log('prinpdf')
        ipcRenderer.send('print-to-pdf');

        this.show();
    }
    show(){
        console.log('aaa')
        ipcRenderer.on('wrote-pdf',(event,path)=>{
            const message = `wrote PDF to ${path}`;
            console.log(`akiii => ${message}`);
        })
    }

    createInvoice(invoice, path) {
        let doc = new PDFDocument({ margin: 50 });
        console.log(invoice,doc);
        this.generateHeader(doc);
        this.generateCustomerInformation(doc, invoice);
        this.generateInvoiceTable(doc, invoice);
        this.generateFooter(doc);
      
        
        doc.pipe(fs.createWriteStream(path));
        doc.end();
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
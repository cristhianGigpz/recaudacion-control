import { remote, ipcRenderer } from 'electron'
import settings from 'electron-settings'
import crypto from 'crypto'

const { Client, Pool } = require('pg')
require('custom-env').env('config')

let usuario = {};


window.addEventListener('load', () => {
  cancelButton()
  //saveButton()
  testConnection()
  muestraUsuario()
  
})

async function testConnection(){
  
  const connectionString = {
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database:  process.env.DB_BASEDATOS,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT,
  }

  const client = new Client(connectionString)

  await client.connect((err)=>{
    if (err) console.log(err)
  })

  /* const res = await client.query('SELECT $1::text as message', ['Hello world!'])
  console.log(res.rows[0].message) // Hello world!
  await client.end() */
  client.query('SELECT * FROM usuario')
  .then((res) =>{
    usuario = res.rows[0]
    //usuario = JSON.parse(usuario)
    //console.log(usuario)
    ipcRenderer.send('connection', usuario)
  })
  .catch(e => console.error(e.stack))

}

function muestraUsuario(){
  //const BrowserWindow = remote.BrowserWindow
  //const mainWindow = remote.getGlobal('win')
      const destino = document.querySelector('#destino')
      //conectado//
      ipcRenderer.on('conectado', (event, usuario)=>{
        console.log(usuario)
        //let newUser = JSON.stringify(usuario)
        const newTemplate = `
          <div class="pane">
            <h2>${usuario.nombre_completo}</h2>
          </div>
        `;
        destino.innerHTML += newTemplate;
      })
}

function cancelButton () {
  const cancelButton = document.getElementById('cancel-button')

  cancelButton.addEventListener('click', () => {
    const prefsWindow = remote.getCurrentWindow()
    prefsWindow.close()
  })
}

function saveButton () {
  const saveButton = document.getElementById('save-button')
  const prefsForm = document.getElementById('preferences-form')

  saveButton.addEventListener('click', () => {
    if (prefsForm.reportValidity()) {
      const cipher = crypto.createCipher('aes192', 'Platzipics')
      let encrypted = cipher.update(document.getElementById('cloudup-passwd').value)
      encrypted += cipher.final('hex')

      settings.set('cloudup.user', document.getElementById('cloudup-user').value)
      settings.set('cloudup.passwd', encrypted)
      const prefsWindow = remote.getCurrentWindow()
      prefsWindow.close()
    } else {
      ipcRenderer.send('show-dialog', {type: 'error', title: 'Platzipics', message: 'Por favor complete los campos requeridos'})
    }
  })
}

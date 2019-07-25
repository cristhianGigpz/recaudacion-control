import {ipcRenderer } from 'electron';
import UI from './main-window/ui'
const ui = new UI();

/**
 * Carga todos los eventos al formulario
 */
window.addEventListener('DOMContentLoaded', () => {
  listGrilla();
  btnRegistro();
  closeRegistroContribuyente();
  register();
  LoadData();
})

/**
 * Inicializa los datos en el formulario
 */
const LoadData =()=>{
  if(document.getElementById('selectUrba')){
    const element = ui.loadGetData('urbanisacion');
    document.getElementById('selectUrba').innerHTML +=`<option value='0'>seleccione urbanisacion</option>`;
    element.then((items)=>{
        items.forEach(e => {
            document.getElementById('selectUrba').innerHTML += `<option value='${e.idurb}'>${e.nomurbanisacion}</option>`;
        });
    });
  }
  listGrilla();
  //ui.closeFrom('cancel-button');
}

const register =()=>{
  if(document.getElementById('btn-guardar')){
    document.getElementById('btn-guardar').addEventListener('click',(e)=>{
      e.preventDefault();
      let cod = parseInt(document.getElementById('cod').value);
      let nombre_razon = document.getElementById('nombre_razon').value;
      let tipo_doc = document.getElementById('selectDoc');
      let  str_tipo_doc = tipo_doc.options[tipo_doc.selectedIndex].value;
      let numero_doc = document.getElementById('numero_doc').value;
      let urb =  document.getElementById('selectUrba');
      let  strUrb = urb.options[urb.selectedIndex].value;
      let direccion = document.getElementById('direccion').value;
      let lote = document.getElementById('lote').value;
      let manzana = document.getElementById('manzana').value;
      let departamento = document.getElementById('departamento').value;
      let numero = document.getElementById('numero').value;
      let total_anexo = document.getElementById('total_anexo').value;
      let impuesto_anual = document.getElementById('impuesto_anual').value;
      let total_exonerado = document.getElementById('total_exonerado').value;
      let total_predio = document.getElementById('total_predio').value;
      let base_imponible = document.getElementById('base_imponible').value;
      let observacion = document.getElementById('observacion').value;
      let telefono = document.getElementById('telefono').value;
      let tipo_persona = document.getElementsByName("rbTipoPersona");
      let tipo_motivo = document.getElementsByName("rbMotivo");
      let check_estado = document.getElementById('checkEstado');
      let check_estado_value = check_estado.checked ? 1 : 0;
      let form = document.getElementById("form-contribuyente");
      
      let valid = ui.validateFrom(form);
      if(valid){
        let tipo_persona_value;
        for(var i = 0; i < tipo_persona.length; i++){
            if(tipo_persona[i].checked){
              tipo_persona_value = tipo_persona[i].value;
            }
        }
        let tipo_motivo_value;
        for(var i = 0; i < tipo_motivo.length; i++){
          if(tipo_motivo[i].checked){
            tipo_motivo_value = tipo_motivo[i].value;
          }
        }
        
        let data ={
          nombre_razon_social:nombre_razon,tipo_doc:str_tipo_doc,
          numero_doc:numero_doc,idurb:strUrb,direccion:direccion,numero:numero,dpto:departamento,manzana:manzana,
          lote:lote,telefono:telefono,tipo_persona:tipo_persona_value,motivo:tipo_motivo_value,diflmpuesto:'1',observacion:observacion,total_anexo:total_anexo,
          estado:check_estado_value,impuesto_anula:impuesto_anual,valor_total_exonerado:total_exonerado,valor_total_predio:total_predio,base_imponible_a:base_imponible
        }
        
        const commanQuery = (cod === 0)
            ?  ui.createInsertQuery('contribuyente',data) 
            : ui.createUpdateQuery('contribuyente',data,'idcontribuyente',cod);
            const result = ui.executeQuery(commanQuery.query,commanQuery.params,'contribuyente');
        reload(result);
        document.getElementById('btn-guardar').innerText ="Guardar";
      }else{
        alert('inserte todos los datos')
      }
    })
  }
}

/**
 * Limpia campo del formulario
 */
const clear =()=>{
  document.getElementById('cod').value = '0';
  document.getElementById('nombre_razon').value='';
  document.getElementById('selectDoc').value=0;
  document.getElementById('numero_doc').value='';
  document.getElementById('selectUrba').value=0;
  document.getElementById('direccion').value='';
  document.getElementById('lote').value='';
  document.getElementById('manzana').value='';
  document.getElementById('departamento').value='';
  document.getElementById('numero').value='';
  document.getElementById('total_anexo').value='';
  document.getElementById('impuesto_anual').value='';
  document.getElementById('total_exonerado').value='';
  document.getElementById('total_predio').value='';
  document.getElementById('base_imponible').value='';
  document.getElementById('observacion').value='';
  document.getElementById('telefono').value='';
  document.getElementsByName("rbTipoPersona").checked=false;
  document.getElementsByName("rbMotivo").checked=false;
  document.getElementById('checkEstado').checked=0 
}

/**
 * Lista los datos de la tabla
 */
const listGrilla =()=>{
  console.log('listado')
  const contrib = ui.loadDataJoinContribuyente();
  console.log(contrib);
  contrib.then((e)=>{LoaderData(e)})
}

/**
 * Recarga la grilla
 * @param {Matriz de datos} element 
 */
const reload =(element)=>{
  element.then((e)=>{
      listGrilla();
      clear();
  });
}

/**
 * Lista todos los datos para presentar en la grilla
 * @param {Matriz de Datos} items 
 */
const LoaderData=(items)=>{
  let card = '';
  items.forEach((e)=>{
    console.log(e)
     /* card +=`<tr>
              <td>${e.iddistrito}</td>
              <td>${e.codigo}</td>
              <td>${e.nomdistrito}</td>
              <td>${e.abreviatura}</td>
              <td>${e.nombre_provincia}</td>
              <td>${e.nombre_departamento}</td>
              <td>
                  <button id="${e.iddistrito}" class="btn-crud" onclick="btnEditar(this)"><span class="icon icon-pencil"></span></button>
                  <button id="${e.iddistrito}" class="btn-crud" onclick="btnDelete(this)"><span class="icon icon-trash"></span></button>
              </td>
          </tr>`;*/
  });
  //document.getElementById("load-dep").innerHTML = card;
}


/**
 * Registra y Actualiza los datos a la tablas
 */
const btnRegistro=()=>{
  ui.openWindows('btn-add',1230,610,'Contribuyente', 'contribuyente');
}
const closeRegistroContribuyente=()=>{
  ui.closeFrom('reg-contribuyente-end');
  ui.closeFrom('btn-close');
  
}

function saveButton () {
  const saveButton = document.getElementById('save-button')
  const prefsForm = document.getElementById('preferences-form')

  saveButton.addEventListener('click', () => {
    /*if (prefsForm.reportValidity()) {
      const cipher = crypto.createCipher('aes192', 'Platzipics')
      let encrypted = cipher.update(document.getElementById('cloudup-passwd').value)
      encrypted += cipher.final('hex')

      settings.set('cloudup.user', document.getElementById('cloudup-user').value)
      settings.set('cloudup.passwd', encrypted)
      const prefsWindow = remote.getCurrentWindow()
      prefsWindow.close()
    } else {
      ipcRenderer.send('show-dialog', {type: 'error', title: 'Platzipics', message: 'Por favor complete los campos requeridos'})
    }*/
  })
}

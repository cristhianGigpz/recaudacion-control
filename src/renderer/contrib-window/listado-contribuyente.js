import UI from "./main-window/ui";
import { loadGetData, executeQuery, createInsertQuery, createUpdateQuery, disconnect } from "../bd/connect"
const ui = new UI();

window.addEventListener("DOMContentLoaded", () => {
    LoadData();
    openAdd();
    //LoadData();
    cancelButton();
});

window.addEventListener("beforeunload", function (event) {
  disconnect();
});

const openAdd = () => {
    ui.openWindows("btn-add", 1230, 610, "Contribuyente", "contribuyente");
};

const cancelButton = () => {
    ui.closeFrom("btn-close");
};

const LoadData = () => {
    listGrilla();
    //disconnect();
    //ui.closeFrom("cancel-button");
  };
  
  /**
   * Lista los datos de la tabla
   */
  const listGrilla = () => {
    //const dep = ui.loadGetData("contribuyente"); //CONECTA CON LA BD Y TRAE DATOS DE TABLA
    const dep = loadGetData("contribuyente");
    dep.then(e => {
      LoaderData(e);
    });
    
  };

  const LoaderData = items => {
    let card = "";
    items.forEach(e => {
      card += `<tr>
                  <td>${e.idcontribuyente}</td>
                  <td>${e.nombre_razon_social}</td>
                  <td>${e.tipo_persona}</td>
                  <td>${e.tipodoc}</td>
                  <td>${e.numerodoc}</td>
                  <td>${e.idurb}</td>
                  <td>${e.direccion}</td>
                  <td>${e.lote}</td>
                  <td>${e.manzana}</td>
                  <td>${e.dpto}</td>
                  <td>${e.numero}</td>
                  <td>${e.telefono}</td>
                  <td>${e.motivo}</td>
                  <td>${e.totalanexo}</td>
                  <td>${e.estado}</td>
                  <td>${e.impuestoanual}</td>
                  <td>${e.valortotalexonerado}</td>
                  <td>${e.valortotalpredio}</td>
                  <td>${e.baseimponiblea}</td>
                  <td>${e.observacion}</td>                  
              </tr>`;
    });
  
    document.getElementById("load-dep").innerHTML = card;
  };
  
  
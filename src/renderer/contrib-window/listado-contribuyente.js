import { ipcRenderer } from "electron";
import UI from "./main-window/ui";
const ui = new UI();

window.addEventListener("DOMContentLoaded", () => {
    //listGrilla();
    btnRegistro();
    //LoadData();
    closeRegistroContribuyente();
});

const btnRegistro = () => {
    ui.openWindows("btn-add", 1230, 610, "Contribuyente", "contribuyente");
};
  const closeRegistroContribuyente = () => {
    ui.closeFrom("reg-contribuyente-end");
    ui.closeFrom("btn-close");
};
  
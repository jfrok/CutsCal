class Reservation extends HTMLElement {
connectedCallback() {
this.innerHTML = `<h1>Hello World...</h1>`;
this.style.color = "grey";
}
}

customElements.define("reservation-element", Reservation);

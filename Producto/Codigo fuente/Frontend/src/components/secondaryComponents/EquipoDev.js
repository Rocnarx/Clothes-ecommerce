import React from 'react';
import './EquipoDev.css';
import miembro1 from '../../Imagenes/miembro1.png';
import miembro2 from '../../Imagenes/miembro2.png';
import miembro3 from '../../Imagenes/miembro3.png';
import miembro4 from '../../Imagenes/miembro4.png';
import miembro5 from '../../Imagenes/miembro5.png';

function EquipoDev() {
  return (
    <div className="equipo-dev">
      <h1>Conoce a Nuestro Equipo de Desarrollo</h1>
      <p>Nos enorgullece contar con un equipo altamente capacitado y apasionado por la tecnología. Cada miembro aporta su experiencia única para crear productos innovadores y de alta calidad.</p>

      <div className="miembros">
        <div className="miembro">
          <img src={miembro1} alt="Miembro 1" className="miembro-imagen" />
          <h2>Juan Grajales </h2>
          <p>Lider</p>
        </div>

        <div className="miembro">
          <img src={miembro2} alt="Miembro 2" className="miembro-imagen" />
          <h2>Christian Lancheros</h2>
          <p>Lider de desarrollo</p>
        </div>

        <div className="miembro">
          <img src={miembro3} alt="Miembro 3" className="miembro-imagen" />
          <h2>Felipe Tibaquicha</h2>
          <p>Lider de calidad </p>
        </div>

        <div className="miembro">
            <img src={miembro4} alt="Miembro 4" className="miembro-imagen" />
            <h2>Cristian Cruz </h2>
            <p>Lider de planeación</p>
        </div>
        </div>
      <div className="mensaje">
      </div>
    </div>
  );
}

export default EquipoDev;

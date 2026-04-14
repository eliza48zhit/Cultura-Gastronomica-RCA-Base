// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaRCA
 * @dev Registro de procesos de desintoxicacion de mandioca y fermentacion envuelta.
 * Serie: Sabores de Africa (23/54)
 */
contract CulturaRCA {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 diasSumergido;    // Tiempo de neutralizacion de toxinas (1-7 dias)
        uint256 presionAtado;     // Firmeza del envoltorio en hojas (1-10)
        bool esFermentado;        // Validador de proceso anaerobico
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Chikwangue (Ingenieria de la seguridad alimentaria)
        registrarPlato(
            "Chikwangue", 
            "Mandioca (Yuca), hojas de Marantaceae, agua.",
            "Remojo prolongado para eliminar cianuro, triturado, fermentacion y doble coccion envuelta.",
            4, 
            9, 
            true
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _remojo, 
        uint256 _presion,
        bool _fermentado
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_remojo >= 3, "Seguridad: Minimo 3 dias de sumergido para neutralizar toxinas");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            diasSumergido: _remojo,
            presionAtado: _presion,
            esFermentado: _fermentado,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 remojo,
        uint256 presion,
        bool fermentado,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.diasSumergido, p.presionAtado, p.esFermentado, p.likes);
    }
}

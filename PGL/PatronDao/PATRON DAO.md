**DAO** o también conocido como **(Data Access Object)**, es un patrón de diseño utilizado en la industria IT para crear conexiones seguras hacia una capa de persistencia. Este patron esta comúnmente implementado con el patron de diseño **Abstract Factory** ademas de tener un fuerte  vinculo con el Patron de entidades **DTO** **(Data Transfer Object)**.

Para comenzar debemos explicar la estructura principal  de este patron de diseño:

![[Pasted image 20230925011134.png]]

#### En este patron tenemos varios componentes:
**BO** (Business Object): Es el primero de los componentes, este es una entidad que representa la lógica de negocio de nuestro proyecto.
**DAO** (Data Access Object): Es el componente encargado de representar e interactuar con la capa de acceso, ocultando en el proceso la fuente de datos y los detalles técnicos de recuperación de los mismos.
**DTO**  (Data Transfer Object) : Este es un componente que integra directamente el patron de diseño de entidades **DTO** el cual crea un puente de mediación entre el **BO** y el **DAO**
**Data Source:** El data source es la capa de persistencia, que ya puede actuar como una base de datos un xml o un csv.

#### Flujo de actividad habitual del Patron DAO

![[Pasted image 20230925011834.png]]

Como se puede observar en la imagen el flujo del programa no es muy complejo ni extenso ya que cada vez que queramos ejecutar alguna consulta en nuestra capa de persistencia debemos crear esta tarea en nuestra aplicación debido a esto el rendimiento de nuestras consultas sera reducido de forma ínfima, pero es una apuesta de valor que debemos hacer para agregar una capa de seguridad a nuestros programas ya que separamos por completo la capa lógica o de usuario del apartado de acceso a datos y de sus detalles técnicos.

#### Como implementar DAO
En primer lugar para poder conseguir la implemetación satisfactoria del patrón de diseño **DAO** debemos reconocer los elementos de nuestra capa lógica y tras eso crear una implementación una clase **DTO** por cada uno de las **entidades** de nuestro proyecto.

```
EJEMPLO:

Crear una clase cliente como objeto de negocio:

public class Cliente {

	private int codigoIdentf;
	private String nombre;
	private String apellido;
	private String email;
	
	//Elementos que no deseamos almacenar en la capa de persistencia.
	private int cantidadFac;
	private int gastoTotal;

	public Cliente(){
		...
	}

	/*Logica de negocio*/

}

Asignar un DTO a nuestra clase cliente con tan solo los atributos que deseemos integrar en nuestra capa de persistencia. Este es una entidad contenedora por lo que no debe contener nada de logica de negocio.

public class DTOCliente{

	private int codigoIndetf;
	private String nombre;
	private String apellido;
	private String email;

	public DTOCliente(){
		...
	}
}
```

Tras realizar esto crearemos una ***interface*** **DAO** para cada entidad del dominio.

```
EJEMPLO:

Crearemos una interfaz que ejecute las acciones sobre nuestra capa de persistencia.

public interface IDAOCliente{

	public void introducirCliente(DTOCliente cliente) throws DAOException;
	public DTOCliente recuperarCliente(DTOCliente cliente) throws DAOException;

}

Es importante resaltar que estas interfaces DAO que definamos a lo largo de nuestro codigo utilizaran su DTO correspondiente.
```

Por ultimo debemos identificar las bases de datos que conforman nuestra capa de persistencia, debemos tener en cuenta que uno de los valores positivos de utilizar el patron de diseño DAO es la fácil implementación de estas. 

```
EJEMPLO:

Crearemos diferentes clases para mostrar el funcionamiento de estas implementaciones:

public class DAOMysqlImpCLiente() implements IDAOCliente{

	private String DBName;
	private ConnectionManager connManager;
	
	public DAOMysqlImpCLiente(){
		//conexion a la BDD
	}

	@Override
	public void introducirCliente(DTOCliente cliente) throws DAOException{
		//insert a la BDD
	}

	@Override
	 public DTOCliente recuperarCliente(DTOCliente cliente) throws DAOException{
		 //Select en la BDD
	 }

}

public class DAOCSVImpCLiente() implements IDAOCliente{

}

public class DAOXMLImpCliente() implements IDAOCliente{

}
```


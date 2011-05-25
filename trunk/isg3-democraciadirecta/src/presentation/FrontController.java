package presentation;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.IUsuarioDAO;
import data.JDBCUsuarioDAO;
import domain.Usuario;

/**
 * Servlet implementation class FrontController
 */
public class FrontController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private IUsuarioDAO usuarioDAO = new JDBCUsuarioDAO();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FrontController() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	public void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		if (logado(request)) {
			String resource = request.getParameter("res");
			RequestDispatcher d = request.getRequestDispatcher(resource);
			if (d != null) {
				d.forward(request, response);
			}
			System.out.println("LOGADO ACCEDIENDO A " + resource);
		} else {
			response.sendRedirect("error.html");
		}
	}

	private boolean logado(HttpServletRequest request) {
		boolean logado = false;
		HttpSession session = request.getSession(false);
		String userForm = request.getParameter("user");
		String passwdForm = request.getParameter("passwd");
		if (session == null) {
			session = request.getSession();
			if (userForm == null || passwdForm == null
					|| userForm.length() == 0 || passwdForm.length() == 0) {
				logado = false;
			} else {
				if (valido(userForm, passwdForm)) {
					logado = true;
					Usuario u = usuarioDAO.select(userForm, passwdForm);
					session.setAttribute("dd.usuario", u);
				} else {
					logado = false;
				}
			}
		} else {
			if (userForm == null || passwdForm == null) {
				logado = true;
			} else {
				if (valido(userForm, passwdForm)) {
					logado = true;
					Usuario u = usuarioDAO.select(userForm, passwdForm);
					session.setAttribute("dd.usuario", u);
				} else {
					logado = false;
				}
			}
		}
		return logado;
	}

	public boolean valido(String userForm, String passwdForm) {
		return usuarioDAO.valida(userForm, passwdForm);
	}
}

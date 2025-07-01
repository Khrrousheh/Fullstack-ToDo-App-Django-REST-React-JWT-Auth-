# 📝 Fullstack ToDo App — Django REST + React (JWT Auth)

A secure, production-ready ToDo application with JWT authentication, built with Django REST Framework (backend) and React (frontend). Users can register, log in, and manage tasks via a REST API with token-based security.

## ⚙️ Tech Stack

- **Backend:** Django, Django REST Framework
- **Frontend:** React (with Hooks)
- **Database:** PostgreSQL (production-ready)
- **Authentication:** JWT (SimpleJWT)
- **Testing:** Django TestCase / APITestCase, React Testing Library, Jest
- **API Communication:** Axios
- **CORS Handling:** `django-cors-headers`
- **Containerization:** Docker
- **Web Server:** Nginx
- **Security:** CORS, HTTPS-ready, token refresh

## 🚀 Features

- 🔐 Secure JWT authentication
- 🧾 Add, edit, and delete ToDo tasks
- ✅ Mark tasks as complete
- 📅 Search tasks by date range
- 🔍 Filter tasks by state (completed, pending)
- 📡 RESTful API integration
- 💬 Real-time updates with React hooks
- 🧪 Unit tested backend and frontend
- 🛡️ Secure and production-ready setup

## 🏗️ Project Structure

```bash
todo-app/
├── backend/
│   ├── manage.py               # Django management script.
│   ├── todo/                   # Django app directory.
│   │   ├── migrations/         # Directory for Django migrations.
│   │   ├── __init__.py         # Initialization file for the Django app.
│   │   ├── admin.py            # Django admin configuration.
│   │   ├── apps.py             # Django app configuration.
│   │   ├── models.py           # Django models.
│   │   ├── serializers.py      # Django REST Framework serializers.
│   │   ├── urls.py             # URL routing for the Django app.
│   │   ├── views.py            # Django views.
│   │   ├── tests.py            # Django tests.
│   │   ├── filters.py          # Django filters for filtering tasks by state and date range.
│   │   └── ...
│   ├── todo_api/               # Project settings directory.
│   │   ├── __init__.py         # Initialization file for the project.
│   │   ├── settings.py         # Django project settings.
│   │   ├── urls.py             # URL routing for the project.
│   │   ├── wsgi.py             # WSGI config for the project.
│   │   └── asgi.py             # ASGI config for the project.
│   ├── requirements.txt        # Python dependencies.
│   ├── .flake8                 # Flake8 configuration.
│   ├── Dockerfile              # Docker configuration for containerizing the backend.
│   └── .env                    # Environment variables.
├── frontend/
│   ├── public/                 # Public assets directory.
│   │   ├── index.html          # Main HTML file
│   │   └── ...
│   ├── src/                    # Source directory for React components.
│   │   ├── components/         # React components directory
│   │   │   ├── TaskList.js     # Component for listing tasks.
│   │   │   ├── TaskForm.js     # Component for creating/editing tasks.
│   │   │   ├── FilterTasks.js  # Component for filtering tasks by state.
│   │   │   ├── SearchTasks.js  # Component for searching tasks by date range.
│   │   │   └── ...
│   │   ├── App.js              # Main React component.
│   │   ├── index.js            # Entry point for the React application.
│   │   ├── App.css             # CSS for the main React component.
│   │   ├── index.css           # Global CSS.
│   │   ├── setupTests.js       # Setup file for tests.
│   │   └── ...
│   ├── package.json            # npm dependencies and scripts.
│   ├── .eslintrc.json          # ESLint configuration.
│   └── Dockerfile              # Docker configuration for containerizing the frontend.
├── .github/
│   └── workflows/              # Directory for GitHub Actions workflows.
│       ├── lint.yml            # Workflow for linting the codebase.
│       ├── test.yml            # Workflow for running tests.
│       └── build.yml           # Workflow for building the Docker image.
├── nginx.conf                  # Nginx configuration file for serving the frontend and proxying API requests to the backend.
├── Dockerfile                  # Docker configuration for combining the backend and frontend into a single image.
├── docker-compose.yml          # Docker Compose file for managing the multi-container setup.
├── LICENSE                     # MIT License 
└── README.md                   # Project documentation.
```

## ⚙️ Setup Instructions

### 📦 Backend (Django + DRF)

1. **Navigate to the backend directory:**

    ```bash
    cd backend
    ```

2. **Create and activate a virtual environment:**

    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows: venv\Scripts\activate
    ```

3. **Install the required packages:**

    ```bash
    pip install -r requirements.txt
    ```

4. **Set up the database:**

    ```bash
    python manage.py migrate
    ```

5. **Run the development server:**

    ```bash
    python manage.py runserver
    ```

📄 Be sure to add CORS support in `settings.py`:

```python
# settings.py
INSTALLED_APPS += ['corsheaders']
MIDDLEWARE.insert(0, 'corsheaders.middleware.CorsMiddleware')
CORS_ALLOW_ALL_ORIGINS = True
```


### 🌐 Frontend (React)
```bash
cd frontend
npm install
npm start
```

### 🧪 Running Tests
#### Django API Tests
```bash
cd backend
python manage.py test
```

#### React Unit Tests
```bash
cd frontend
npm test
```

### 🛠️ Additional Setup
#### 🐳 Docker
To build and run the Docker containers:

1. **Build the Docker images:**

    ```bash
    docker-compose build
    ```

2. **Run the Docker containers:**

    ```bash
    docker-compose up
    ```

#### Environment Variables

Create a `.env` file in the `backend` directory with the following content:

```env
SECRET_KEY=your_secret_key
DEBUG=1
DB_NAME=your_db_name
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_HOST=your_db_host
DB_PORT=your_db_port
```

#### Nginx Configuration
Ensure that Nginx is properly configured to serve the frontend and proxy API requests to the backend. The nginx.conf file should be placed in the root directory of your project.

```config
server {
    listen 80;

    location / {
        root /usr/share/nginx/html;
        try_files \$uri /index.html;
    }

    location /api/ {
        proxy_pass http://localhost:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    location /static/ {
        alias /app/static/;
    }

    location /media/ {
        alias /app/media/;
    }
}
```

#### Docker Compose
Create a docker-compose.yml file in the root directory to manage the multi-container setup.
```yml
version: '3.8'

services:
  backend:
    build: ./backend
    container_name: todo-backend
    ports:
      - "8000:8000"
    volumes:
      - ./backend:/app
    environment:
      - SECRET_KEY=your_secret_key
      - DEBUG=1
      - DB_NAME=your_db_name
      - DB_USER=your_db_user
      - DB_PASSWORD=your_db_password
      - DB_HOST=your_db_host
      - DB_PORT=your_db_port

  frontend:
    build: ./frontend
    container_name: todo-frontend
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
    depends_on:
      - backend

  nginx:
    build: .
    container_name: todo-nginx
    ports:
      - "80:80"
    depends_on:
      - backend
      - frontend
```

## 🔌 API Endpoints
| Method | Endpoint    						  | Description	      |
|--------|--------------------------------------------------------------|---------------------------|
|POST	   |/api/register/	 					  |Register a new user	      |
|POST	   |/api/login/	 	 					  |Log in a user	      |
|POST	   |/api/token/refresh/	 					  |Refresh JWT token	      |
|GET	   |/api/tasks/		 					  |List all tasks	      |
|POST	   |/api/tasks/		 					  |Create a new task	      |
|GET	   |/api/tasks/:id/	 					  |Retrieve a specific task   |
|PUT	   |/api/tasks/:id/	 					  |Update a task	      |
|DELETE	   |/api/tasks/:id/	 					  |Delete a task	      |
|GET	   |/api/tasks/filter/?state={state}	 			  |Filter tasks by state      |
|GET	   |/api/tasks/search/?start_date={start_date}&end_date={end_date}|Search tasks by date range |

## 💡 To Learn More
- [Django](https://www.djangoproject.com/)
- [Django REST Framework Docs](https://www.django-rest-framework.org/)
- [React Docs](https://react.dev/learn)
- [Jest](https://jestjs.io/docs/getting-started)
- React [Testing Library](https://testing-library.com/)
- [Docker](https://docs.docker.com/)
- [SimpleJWT](https://django-rest-framework-simplejwt.readthedocs.io/en/latest/)

---
MIT License © 2025 Mahdi Khrrousheh
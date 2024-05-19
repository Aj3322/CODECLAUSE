import os

# Define the project structure
project_structure = {
    "lib": {
        "controllers": [
            "scan_controller.dart",
            "history_controller.dart",
            "settings_controller.dart"
        ],
        "models": [
            "scan_model.dart"
        ],
        "services": [
            "storage_service.dart"
        ],
        "views": [
            "scan_view.dart",
            "history_view.dart",
            "settings_view.dart"
        ],
        "main.dart": None,
        "routes.dart": None
    }
}

# Base directory of the Flutter project
base_dir = "qr_barcode_scanner"  # Change this to your project's base directory if different

# Create the project structure
def create_structure(base_path, structure):
    for name, content in structure.items():
        path = os.path.join(base_path, name)
        if isinstance(content, dict):
            os.makedirs(path, exist_ok=True)
            create_structure(path, content)
        elif isinstance(content, list):
            os.makedirs(path, exist_ok=True)
            for file in content:
                open(os.path.join(path, file), 'w').close()
        else:
            open(path, 'w').close()

# Create the project structure
create_structure(base_dir, project_structure)

print("Project structure created successfully.")

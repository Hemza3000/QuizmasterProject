package controller;

import database.mysql.UserDAO;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import model.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import view.Main;

public class CreateUpdateUserController {

    private static final Logger LOGGER = LogManager.getLogger(CreateUpdateUserController.class);
    private static final WarningMessage[] WARNING_MESSAGES =
            new WarningMessage[]{WarningMessage.USER_FIRSTNAME, WarningMessage.USER_LASTNAME,
                    WarningMessage.USER_USERNAME, WarningMessage.USER_PASSWORD};
    private static boolean isValidInput;
    private static boolean userHasUpdate;
    private final UserDAO userDAO;
    @FXML
    Label labelTitle;
    @FXML
    TextField textFieldFirstName;
    @FXML
    Label labelWarnFirstName;
    @FXML
    TextField textFieldLastName;
    @FXML
    Label labelWarnLastName;
    @FXML
    TextField textFieldUserName;
    @FXML
    Label labelWarnUserName;
    @FXML
    PasswordField passwordFieldPassword;
    @FXML
    Label labelWarnPassword;
    @FXML
    Button buttonMenu;
    @FXML
    Button buttonCreateUpdate;
    private TextField[] inputFields;
    private Label[] warningLabels;
    private User user;
    private String[] inputItems;

    public CreateUpdateUserController() {
        userDAO = new UserDAO(Main.getDBaccess());
        inputItems = new String[4];
    }

    /**
     * Sets up the view. Stores user input in a String[], warning labels in a Label[] and warning
     * messages in a
     * WarningMessage[]. Then loops through the String[] to check if the elements contain a
     * String. If not the the warning label text is set to the corresponding warning message.
     *
     * @see WarningMessage
     * @since 1.0.0
     */
    public void setup(User user) {
        userHasUpdate = false;
        inputFields = new TextField[]{textFieldFirstName, textFieldLastName, textFieldUserName,
                passwordFieldPassword};
        warningLabels = new Label[]{labelWarnFirstName, labelWarnLastName, labelWarnUserName,
                labelWarnPassword};
        this.user = user;
        textFieldFirstName.setText(user.getFirstName());
        textFieldLastName.setText(user.getLastName());
        textFieldUserName.setText(user.getUserName());
        passwordFieldPassword.setText(user.getPassword());
        // Initially unfocus the textfield
        textFieldFirstName.getParent().requestFocus();
    }

    public void doMenu() {
        Main.getSceneManager().showManageUserScene();
    }

    public void doCreateUpdateUser() {
        updateFields(); // updates all fields and sets isValidInput
        if (isValidInput) {
            updateUser(); // updates user and sets userHasUpdate if attributes have valid changes
        }
        if (user.getIdUser() == 0 && userHasUpdate) { // storing a valid new user
            userDAO.storeOne(user);
            doMenu();
            showAlert(Operation.CREATE);
        } else if (userHasUpdate) { // storing a valid updated user
            userDAO.updateOne(user);
            doMenu();
            showAlert(Operation.UPDATE);
        } else if (isValidInput && !userHasUpdate) {
            doMenu();
            showAlert(Operation.NONE);
        } else {
            notifyInvalidInput();
        }
    }

    public void doDeleteUser() {
        userDAO.deleteOne(user);
    }

    private boolean isEmptyField(TextField inputField) {
        if (inputField.getText().isEmpty()) {
            return true;
        }
        return false;
    }

    private void updateFields() {
        isValidInput = true;
        for (int i = 0; i < inputFields.length; i++) {
            warningLabels[i].setText("");
            inputFields[i].setStyle("-fx-border-color: inherit;");
            if (isEmptyField(inputFields[i])) {
                warningLabels[i].setText(WARNING_MESSAGES[i].getMessage());
                inputFields[i].setStyle("-fx-border-color:red;");
                isValidInput = false;
            }
        }
    }

    /**
     * Notifies the user of any invalid input. First sets the border color of all input fields to
     * the default color, and warning labels to an empty String. This removes styling and messages
     * from previous method calls, if any. After this user input is collected by calling
     * {@link TextInputControl#getText()} on all input fields. If a field is empty, the user is
     * notified by a highlighting the input field border and displaying a warning label.
     *
     * @see WarningMessage
     * @since 1.0.0
     */
    public void notifyInvalidInput() {
        for (int i = 0; i < inputFields.length; i++) {
            inputFields[i].setStyle("-fx-border-color:inherit;");
            warningLabels[i].setText("");
            inputItems[i] = inputFields[i].getText();
            if (inputItems[i].isEmpty()) {
                inputFields[i].setStyle("-fx-border-color:red;");
                warningLabels[i].setText(WARNING_MESSAGES[i].getMessage());
            }
        }
    }

    public void updateUser() {
        User updatedUser = new User.UpdateUser()
                .withIdUser(user.getIdUser())
                .withFirstName(inputFields[0].getText())
                .withLastName(inputFields[1].getText())
                .withUserName(inputFields[2].getText())
                .withPassword(inputFields[3].getText())
                .withRole(user.getRole())
                .update();
        if (updatedUser.equals(user)) {
            userHasUpdate = false;
        } else {
            userHasUpdate = true;
            user = updatedUser;
        }

    }

    public void showAlert(Operation operation) {
        String alertMessage = "";
        Alert alert = new Alert(Alert.AlertType.INFORMATION, alertMessage);
        alert.setTitle("Meldingvenster");
        alert.setHeaderText("");
        switch (operation) {
            case NONE:
                alert.setHeaderText("Geen wijzigingen");
                alertMessage = "Er zijn geen wijzigingen opgeslagen.";
                break;
            case CREATE:
                alert.setHeaderText("Opgeslagen");
                alertMessage = "Nieuwe gebruiker '" + user.getUserName() + "' is opgeslagen.";
                break;
            case UPDATE:
                alert.setHeaderText("Opgeslagen");
                alertMessage = "Je wijzigingen zijn opgeslagen.";
                break;
        }
        alert.setContentText(alertMessage);
        alert.show();
    }

    private enum Operation {
        NONE, CREATE, UPDATE;
    }

}

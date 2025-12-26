const confirmBenefitsRadioContainer = document.querySelector(`[data-field-name=${"Поле21985454"}]`); // Добавить переменную
const confirmBenefitsRadioContainerText = Array.from(
    confirmBenefitsRadioContainer.querySelectorAll("span")
).find((el) => el.textContent.includes("Нет"));
confirmBenefitsRadioContainerText.previousElementSibling.checked = true;

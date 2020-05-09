window.addEventListener("trix-file-accept", (event) => {
    const acceptedTypes = ['image/jpeg', 'image/png', 'image/gif']
    if (!acceptedTypes.includes(event.file.type)) {
        event.preventDefault()
        alert("Only support attachment of jpeg, png and gif files")
    }

    const maxFileSize = 1024 * 1024
    if (event.file.size > maxFileSize) {
        event.preventDefault()
        alert("Only support attachment files upto size 1MB!")
    }
})
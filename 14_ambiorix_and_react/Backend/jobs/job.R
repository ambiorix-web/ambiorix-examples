

job <- async(function() {
    await(setupDatabase())
    tryCatch(
        {
            while (TRUE) {
                await(callAndStoreUserData())
                await(async_sleep(10))  
            }
        }
    )
})

/* Extension Helper - Webternet */

Download_Webternet(const String:url[], const String:dest[])
{
	new Handle:session = HTTP_CreateSession();
	new Handle:downloader = HTTP_CreateFileDownloader(dest);
	decl String:sError[256];
	
	if (session != INVALID_HANDLE)
	{
		HTTP_SetFailOnHTTPError(session, true);
	}
	else
	{
		FormatEx(sError, sizeof(sError), "Couldn't create session!");
		DownloadEnded(false, sError);
		return;
	}
	
	if (!HTTP_Download(session, downloader, url, OnWebternetComplete))
	{
		FormatEx(sError, sizeof(sError), "Couldn't queue download!");
		DownloadEnded(false, sError);
		return;
	}
}

public OnWebternetComplete(Handle:session, bool:succeeded, Handle:downloader, any:data)
{
	CloseHandle(downloader);

	if (succeeded)
	{
		DownloadEnded(true);
	}
	else
	{
		decl String:sError[256];
		HTTP_GetLastError(session, sError, sizeof(sError));
		Format(sError, sizeof(sError), "Webternet error: %s", sError);
		DownloadEnded(false, sError);
	}
	
	CloseHandle(session);
}
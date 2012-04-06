import std.stdio;
import deimos.ocilib;

int main()
{
	OCI_Connection *cn;
	OCI_Statement *st;
	OCI_Resultset *rs;

	if (! OCI_Initialize(null, null, OCI_ENV_DEFAULT))
	{
		printf("OCI_Initialize failed\n");
		return 1;
	}

	cn = OCI_ConnectionCreate("xe", "hr", "hr", OCI_SESSION_DEFAULT);
	st = OCI_StatementCreate(cn);

	OCI_ExecuteStmt(st, "SELECT * FROM COUNTRIES");

	rs = OCI_GetResultset(st);

	while (OCI_FetchNext(rs))
	{    
		printf("%s\t%s\t%d\n", OCI_GetString(rs, 1), OCI_GetString(rs, 2), OCI_GetInt(rs, 3));
	}

	OCI_Cleanup();
	return 0;
}
